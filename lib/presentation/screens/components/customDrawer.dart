import 'package:flutter/material.dart';
import 'package:jugadu/helper/constants.dart';
import 'package:jugadu/helper/helper_functions.dart';
import 'package:jugadu/presentation/screens/drawer_screen.dart';
import 'package:jugadu/presentation/screens/products_screen.dart';
import 'package:jugadu/size_config.dart';

class CustomDrawer extends StatefulWidget {
  static const String routeName = '/drawer';
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    super.initState();
  }

  getUserInfo() async {
    // Constants.myName = await HelperFunctions.getNameSharedPreference();

    Constants.myEmail = await HelperFunctions.getUserEmailSharedPreference();
    // Constants.myUsername =
    //     await HelperFunctions.getUserNameSharedPreference();
    Constants.userId = await HelperFunctions.getUserIdSharedPreference();
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final double maxSlide = SizeConfig.widthMultiplier * 50;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        double slide = maxSlide * _animationController.value;
        double scale = 1 - (_animationController.value * 0.3);
        return Stack(
          children: [
            DrawerScreen(),
            Transform(
              transform: Matrix4.identity()
                ..translate(slide)
                ..scale(scale),
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  if (!_animationController.isDismissed)
                    _animationController.reverse();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      _animationController.value *
                          SizeConfig.widthMultiplier *
                          10,
                    ),
                  ),
                  child: ProductsScreen(toggle),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
