import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/User.dart';
import '../Models/profile.dart';
import '../Screens/profile_page.dart';
import '../Screens/profile_screen.dart';
import '../Screens/search_screen.dart';
import '../Screens/settings_page.dart';
import '../Screens/settings_screen.dart';
import '../Screens/sign_in_screen.dart';
import '../constants.dart';

PreferredSizeWidget myAppBar(BuildContext context){
  return AppBar(
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
        //Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SignInScreen()));
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
  );
}

Widget myBottomAppBar(BuildContext context){
  return BottomAppBar(
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          color: primaryColor[300],
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SettingsPage()));
          },
        ),
        IconButton(
          icon: const Icon(Icons.account_circle_outlined),
          color: primaryColor[300],
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            final user_id = prefs.getInt('user_id') ?? '';

            var resp = await Profile().getProfile(user_id.toString());
            var resp2 = await Profile().getProfilePic(user_id.toString());

            var myUser = User(
              user_id: resp[0]["id"],
              email: resp[0]["email"],
              name: resp[0]["name"],
              comments: resp[0]["comments"].toString(),
              reg_date: resp[0]["reg_date"].toString(),
              study_year: resp[0]["study_year"].toString(),
              image: resp2 == null ? const AssetImage("assets/Images/profile-unknown.png") : resp2,
              permission: resp[0]["permission"].toString().toLowerCase() == 'true' ? true : false
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
                // Pass the arguments as part of the RouteSettings. The
                // DetailScreen reads the arguments from these settings.
                settings: RouteSettings(
                  arguments: myUser,
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}