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

  responseBar(String text, Color? color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          text,
          //textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

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

            if (resp == null) {
              responseBar("There was en error during execution. Check your connection.", secondaryColor);
            }
            else {
              if (resp.statusCode == 200) {
                //responseBar("Registration successful", primaryColor);
                var resp2 = await Profile().getProfilePic(user_id.toString());

                if (resp2 == null) {
                  responseBar("There was en error fetching profile picture.", secondaryColor);
                }
                else {
                  if (resp2[0].statusCode == 200 || resp2[0].statusCode == 404) {
                    var myUser = User(
                        user_id: resp.data[0]["id"],
                        email: resp.data[0]["email"],
                        name: resp.data[0]["name"],
                        comments: resp.data[0]["comments"].toString(),
                        reg_date: resp.data[0]["reg_date"].toString(),
                        study_year: resp.data[0]["study_year"].toString(),
                        image: resp2[1] ?? const AssetImage("assets/Images/profile-unknown.png"),
                        permission: resp.data[0]["permission"].toString().toLowerCase() == 'true' ? true : false
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
                  }
                  else if (resp2[0].statusCode == 401) {
                    responseBar(resp2[0].data["detail"], secondaryColor);
                  }
                  else if (resp2[0].statusCode >= 500) {
                    responseBar("There is an error on server side, sit tight...", secondaryColor);
                  }
                  else {
                    responseBar("There was en error fetching profile picture.", secondaryColor);
                  }
                }
              }
              else if (resp.statusCode == 401 || resp.statusCode == 404) {
                responseBar(resp.data["detail"], secondaryColor);
              }
              else if (resp.statusCode >= 500) {
                responseBar("There is an error on server side, sit tight...", secondaryColor);
              }
              else {
                responseBar("There was en error during execution.", secondaryColor);
              }
            }
          },
        ),
      ],
    ),
  );
}