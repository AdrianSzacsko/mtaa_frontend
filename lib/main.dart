import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './Screens/login_screen.dart';
import './Screens/signup_screen.dart';
import './Screens/welcome_screen.dart';
import './Screens/search_screen.dart';
import './Screens/register_screen.dart';
import './Screens/sign_in_screen.dart';
import './Models/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomeScreen(),
        routes: {
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          SignupScreen.routeName: (context) => SignUpScreen(),
          LoginScreen.routeName: (context) => SignInScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
        },
      ),
    );
  }
}