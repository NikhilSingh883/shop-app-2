import 'package:flutter/material.dart';
import 'package:jugadu/size_config.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage(
                  'assets/images/loading.gif',
                ),
                fit: BoxFit.contain,
                height: SizeConfig.heightMultiplier * 20,
              ),
            ),
            // Text(
            //   'Loading...',
            //   style: TextStyle(color: Colors.white60, fontSize: 20),
            // ),
          ]),
    );
  }
}
