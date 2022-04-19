import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtaa_frontend/constants.dart';
import 'package:provider/provider.dart';
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
          primarySwatch: primaryColor,
          fontFamily: "Roboto",
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,)
        ),
        home: SignInScreen(),
        routes: {
          SearchScreenState.routeName: (context) => SearchScreen(),
        },
      ),
    );
  }
}