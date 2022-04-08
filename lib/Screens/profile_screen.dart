import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mtaa_frontend/Screens/settings_screen.dart';
//import 'package:flutter/rendering.dart';
import 'package:mtaa_frontend/UI/inputField.dart';
import 'package:mtaa_frontend/Screens/search_screen.dart';
import 'package:mtaa_frontend/Screens/sign_in_screen.dart';
import 'package:mtaa_frontend/UI/appbar.dart';

import '../constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  //SearchScreen({Key key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  static const routeName = '/settings-screen';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      bottomNavigationBar: myBottomAppBar(context),
    );
  }
}