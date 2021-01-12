import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jugadu/helper/constants.dart';
import 'package:jugadu/presentation/screens/cart_screen.dart';
import 'package:jugadu/presentation/screens/orders_screen.dart';
import 'package:jugadu/presentation/screens/welcome_screen.dart';
import 'package:jugadu/presentation/widgets/iconWithText.dart';
import 'package:jugadu/size_config.dart';
import 'package:jugadu/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            stops: [0.1, 0.3, 0.6, 0.9],
            colors: [
              Color(0xFF33691E),
              Color(0XFF558B2F),
              Color(0XFF8BC34A),
              Color(0XFF9CCC65),
            ],
          ))),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 3,
                        ),
                        child: Image(
                          image: AssetImage(
                            'assets/images/user.png',
                          ),
                          fit: BoxFit.cover,
                          height: SizeConfig.heightMultiplier * 10,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 3,
                        ),
                        child: Text(
                          Constants.myEmail,
                          style: AppTheme.title,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 18,
                  ),
                  IconWithText(
                    FontAwesomeIcons.cartPlus,
                    'Cart',
                    () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                  ),
                  IconWithText(
                    FontAwesomeIcons.firstOrder,
                    'Orders',
                    () {
                      Navigator.of(context).pushNamed(OrderScreen.routeName);
                    },
                  ),
                  IconWithText(
                    FontAwesomeIcons.signOutAlt,
                    'SignOut',
                    () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context)
                          .pushReplacementNamed(WelcomeScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
