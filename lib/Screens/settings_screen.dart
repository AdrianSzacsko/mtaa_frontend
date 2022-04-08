import 'dart:ffi';

import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:mtaa_frontend/Screens/welcome_screen.dart';
import 'package:mtaa_frontend/UI/inputField.dart';
import 'package:mtaa_frontend/Screens/search_screen.dart';
import 'package:mtaa_frontend/Screens/sign_in_screen.dart';

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
          centerTitle: true,
          title: IconButton(
            icon: const Icon(Icons.home_rounded,
                color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SignInScreen()));
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search,
                  color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
              },
            ),
          ],
        ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
              },
            ),
            IconButton(
              icon: Icon(Icons.assignment_ind),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}