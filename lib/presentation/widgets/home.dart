import 'package:flutter/material.dart';
import 'package:jugadu/presentation/widgets/primaryButton.dart';
import 'package:jugadu/size_config.dart';
import 'package:jugadu/theme.dart';

class HomeWidget extends StatelessWidget {
  final Function changePage;

  HomeWidget(this.changePage);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 1000),
      color: Colors.green[200],
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.s,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              changePage(0);
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: Duration(milliseconds: 1000),
                    margin: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier * 10,
                    ),
                    child: Text(
                      "Jugadu.in".toUpperCase(),
                      style: AppTheme.title,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 2,
                      vertical: SizeConfig.heightMultiplier,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 6,
                    ),
                    child: Text(
                      "Basic shopping application with complex UI/UX",
                      textAlign: TextAlign.center,
                      style: AppTheme.subtitle,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.heightMultiplier * 3,
              vertical: SizeConfig.widthMultiplier * 2,
            ),
            child: Center(
              child: Image.asset(
                "assets/images/home.png",
                height: SizeConfig.heightMultiplier * 20,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Spacer(),
          Container(
            child: GestureDetector(
              onTap: () {
                changePage(1);
              },
              child: PrimaryButton(
                btnText: 'Get Started',
              ),
            ),
          )
        ],
      ),
    );
  }
}
