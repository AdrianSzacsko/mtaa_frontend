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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.lightBlueAccent,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "   Settings:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () {
                  //TODO add info
                },
                child: const Text("Info",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () {
                  //TODO add webrtc call screen
                },
                child: const Text("Call Support",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          elevation: 16,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: const Text("Are you sure you want to permanently delete your account?",
                                  style: TextStyle(
                                    fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                },
                child: const Text("Delete Account",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}