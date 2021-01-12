import 'package:flutter/material.dart';
import 'package:jugadu/size_config.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function func;
  IconWithText(this.icon, this.text, this.func);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: SizeConfig.widthMultiplier * 25,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier,
            vertical: SizeConfig.heightMultiplier),
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 3,
          vertical: SizeConfig.heightMultiplier,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeConfig.widthMultiplier * 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 3,
            ),
            Container(
              child: FittedBox(
                child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.heightMultiplier * 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
