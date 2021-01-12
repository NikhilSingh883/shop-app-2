import 'package:flutter/material.dart';
import 'package:jugadu/size_config.dart';

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  final TextEditingController controller;
  final String type;
  InputWithIcon({this.icon, this.hint, this.controller, this.type});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFBC7C7C7), width: 2),
        borderRadius: BorderRadius.circular(SizeConfig.heightMultiplier * 6),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: SizeConfig.widthMultiplier * 12,
            child: Icon(
              widget.icon,
              size: SizeConfig.heightMultiplier * 2,
              color: Color(0xFFBB9B9B9),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                right: SizeConfig.widthMultiplier * 6,
              ),
              child: TextFormField(
                controller: widget.controller,
                autocorrect: false,
                textCapitalization: widget.type == 'email'
                    ? TextCapitalization.none
                    : TextCapitalization.sentences,
                enableSuggestions: false,
                key: ValueKey(widget.type),
                style: TextStyle(color: Colors.white70),
                obscureText: widget.type == 'email' ? false : true,
                validator: (value) {
                  if (widget.type == 'email') {
                    if (value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.com')) return 'Enter a Valid Email!';
                  } else {
                    if (value.isEmpty || value.length < 7)
                      return 'Password should be atleast 7';
                    if (!value.contains('@') &&
                        !value.contains('.') &&
                        !value.contains('-'))
                      return 'Add some special character';
                  }
                  return null;
                },
                keyboardType: widget.type == 'email'
                    ? TextInputType.emailAddress
                    : TextInputType.visiblePassword,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  hintText: widget.hint,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
