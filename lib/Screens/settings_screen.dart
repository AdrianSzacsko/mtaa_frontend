import 'dart:ffi';

import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:mtaa_frontend/Screens/welcome_screen.dart';
import 'package:mtaa_frontend/UI/inputField.dart';
import 'package:mtaa_frontend/Screens/search_screen.dart';
import 'package:mtaa_frontend/Screens/sign_in_screen.dart';

import '../constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  //SearchScreen({Key key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  static const routeName = '/settings-screen';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: primaryColor[300], //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: IconButton(
            icon: Image.asset('assets/Images/puzzle.png',
              height: 80.0,
              fit: BoxFit.cover,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SignInScreen()));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search_outlined,
                  color: primaryColor[300]),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
              },
            ),
          ],
        ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.settings_outlined),
              color: primaryColor[300],
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle_outlined),
              color: primaryColor[300],
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
              },
            ),
          ],
        ),
      ),
      body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: backgroundColor,
      )
    );
  }
}