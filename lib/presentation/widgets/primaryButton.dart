import 'package:flutter/material.dart';
import 'package:jugadu/size_config.dart';
import 'package:jugadu/theme.dart';

class PrimaryButton extends StatefulWidget {
  final String btnText;
  final Function onTap;
  PrimaryButton({this.btnText, this.onTap});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 6,
          vertical: SizeConfig.heightMultiplier * 3,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 4,
          vertical: SizeConfig.heightMultiplier * 2,
        ),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xFFB40284A), borderRadius: BorderRadius.circular(50)),
        child: Text(
          widget.btnText,
          style: AppTheme.buttonStyle,
        ),
      ),
    );
  }
}
