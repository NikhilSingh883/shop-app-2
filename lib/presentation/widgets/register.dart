import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jugadu/firebase/firebaseMethods.dart';
import 'package:jugadu/presentation/widgets/inputWithIcon.dart';
import 'package:jugadu/presentation/widgets/outlineButton.dart';
import 'package:jugadu/presentation/widgets/primaryButton.dart';

class RegisterWidget extends StatefulWidget {
  final Function changePage;
  final double registerYOffset;
  final double registerHeight;

  const RegisterWidget({
    @required this.changePage,
    @required this.registerYOffset,
    @required this.registerHeight,
  });

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
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
    print(_userPassword);
    print(_userEmail);
    try {
      await FirebaseMethods().signUp(
        email: _userEmail,
        password: _userPassword,
        context: context,
        auth: _auth,
      );
      widget.changePage(1);
    } catch (err) {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.registerHeight,
      padding: EdgeInsets.all(32),
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 1000),
      transform: Matrix4.translationValues(0, widget.registerYOffset, 1),
      decoration: BoxDecoration(
        color: Colors.deepOrange[200],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Create a New Account",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                child: Form(
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              PrimaryButton(
                btnText: "Create Account",
                onTap: () {
                  onSubmit(context);
                },
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  widget.changePage(1);
                },
                child: OutlineBtn(
                  btnText: "Back To Login",
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
