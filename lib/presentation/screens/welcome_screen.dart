import 'package:flutter/material.dart';
import 'package:jugadu/presentation/widgets/home.dart';
import 'package:jugadu/presentation/widgets/login.dart';
import 'package:jugadu/presentation/widgets/register.dart';
import 'package:jugadu/size_config.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _pageState = 0;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
  }

  changePage(int page) {
    if (page != _pageState)
      setState(() {
        _pageState = page;
      });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    windowHeight = SizeConfig.heightMultiplier * 100;
    windowWidth = SizeConfig.widthMultiplier * 100;

    switch (_pageState) {
      case 0:
        _loginWidth = SizeConfig.orientation == Orientation.landscape
            ? windowHeight
            : windowWidth;
        _loginOpacity = 1;

        _loginYOffset = windowHeight;
        _loginHeight = _keyboardVisible
            ? windowHeight
            : windowHeight - SizeConfig.heightMultiplier * 33;

        _loginXOffset = 0;
        _registerYOffset = SizeConfig.orientation == Orientation.landscape
            ? windowWidth
            : windowHeight;
        break;
      case 1:
        _loginWidth = SizeConfig.orientation == Orientation.landscape
            ? windowHeight
            : windowWidth;
        _loginOpacity = 1;
        _loginHeight = SizeConfig.heightMultiplier * 67;
        _loginYOffset = SizeConfig.heightMultiplier * 33;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 2:
        _loginWidth = windowWidth - SizeConfig.widthMultiplier * 8;
        _loginOpacity = 0.7;

        _loginYOffset = SizeConfig.orientation == Orientation.portrait
            ? SizeConfig.heightMultiplier * 26
            : SizeConfig.widthMultiplier * 20;
        _loginHeight = windowHeight - 240;

        _loginXOffset = SizeConfig.widthMultiplier * 4;
        _registerYOffset = SizeConfig.heightMultiplier * 33;
        _registerHeight = SizeConfig.heightMultiplier * 67;
        break;
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomeWidget(changePage),
          LoginWidget(
            changePage: changePage,
            loginOpacity: _loginOpacity,
            loginXOffset: _loginXOffset,
            loginYOffset: _loginYOffset,
            loginHeight: _loginHeight,
            loginWidth: _loginWidth,
          ),
          RegisterWidget(
            changePage: changePage,
            registerYOffset: _registerYOffset,
            registerHeight: _registerHeight,
          )
        ],
      ),
    );
  }
}

Widget showSB(String msg) {
  return SnackBar(
    content: Text(msg),
    duration: const Duration(seconds: 10),
    action: SnackBarAction(
      label: 'Okay',
      onPressed: () {
        print('Action is clicked');
      },
      textColor: Colors.white,
      disabledTextColor: Colors.grey,
    ),
    onVisible: () {
      print('Snackbar is visible');
    },
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(30.0),
    padding: EdgeInsets.all(15.0),
  );
}
