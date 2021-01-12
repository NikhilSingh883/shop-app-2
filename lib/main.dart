import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jugadu/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jugadu/presentation/screens/cart_screen.dart';
import 'package:jugadu/presentation/screens/components/customDrawer.dart';
import 'package:jugadu/presentation/screens/loading_screen.dart';
import 'package:jugadu/presentation/screens/orders_screen.dart';
import 'package:jugadu/presentation/screens/welcome_screen.dart';
import 'package:jugadu/provider/cartProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.teal,
            actionTextColor: Colors.white,
            disabledActionTextColor: Colors.grey,
            contentTextStyle: TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            behavior: SnackBarBehavior.floating,
          ),
          textTheme:
              GoogleFonts.dmSansTextTheme().apply(displayColor: kTextColor),
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            brightness: Brightness.light,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider(),
          ),
        ],
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return LoadingScreen();
            if (snapshot.hasData) return CustomDrawer();
            return WelcomeScreen();
          },
        ),
      ),
      routes: {
        CartScreen.routeName: (context) => CartScreen(),
        OrderScreen.routeName: (context) => OrderScreen(),
        CustomDrawer.routeName: (context) => CustomDrawer(),
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
      },
    );
  }
}
