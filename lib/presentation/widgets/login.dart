import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jugadu/firebase/firebaseMethods.dart';
import 'package:jugadu/presentation/widgets/inputWithIcon.dart';
import 'package:jugadu/presentation/widgets/outlineButton.dart';
import 'package:jugadu/presentation/widgets/primaryButton.dart';
import 'package:jugadu/size_config.dart';

class LoginWidget extends StatefulWidget {
  final Function changePage;
  final double loginXOffset;
  final double loginYOffset;
  final double loginOpacity;
  final double loginHeight;
  final double loginWidth;
  LoginWidget({
    @required this.changePage,
    @required this.loginXOffset,
    @required this.loginYOffset,
    @required this.loginOpacity,
    @required this.loginHeight,
    @required this.loginWidth,
  });

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  onSubmit(BuildContext context) async {
    final isValid = _formKey.currentState.validate();
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (isValid)
      _formKey.currentState.save();
    else
      return;

    var _userEmail = _email.text.trim();
    var _userPassword = _pass.text.trim();

    await FirebaseMethods().signIn(
      email: _userEmail,
      password: _userPassword,
      context: context,
      auth: _auth,
    );
  }

  resetPass(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    var _userEmail = _email.text.trim();

    await FirebaseMethods().resetPassword(
      email: _userEmail,
      context: context,
      auth: _auth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.loginHeight,
      width: widget.loginWidth,
      padding: EdgeInsets.all(32),
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 1000),
      transform: Matrix4.translationValues(
          widget.loginXOffset, widget.loginYOffset, 1),
      decoration: BoxDecoration(
          color: Colors.indigo[200].withOpacity(widget.loginOpacity),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: GestureDetector(
        onTap: () {
          widget.changePage(1);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Login To Continue",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputWithIcon(
                        icon: Icons.email,
                        hint: "Enter Email...",
                        controller: _email,
                        type: 'email',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        icon: Icons.vpn_key,
                        hint: "Enter Password...",
                        controller: _pass,
                        type: 'pass',
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      FlatButton(
                        child: Text('Forgot Password ?'),
                        onPressed: () {
                          resetPass(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                PrimaryButton(
                  btnText: "Login",
                  onTap: () {
                    onSubmit(context);
                  },
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                GestureDetector(
                  onTap: () {
                    widget.changePage(2);
                  },
                  child: OutlineBtn(
                    btnText: "Create New Account",
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
