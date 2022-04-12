import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mtaa_frontend/Screens/profile_screen.dart';
//import 'package:flutter/rendering.dart';
import 'package:mtaa_frontend/UI/inputField.dart';
import 'package:mtaa_frontend/Screens/search_screen.dart';
import 'package:mtaa_frontend/Screens/sign_in_screen.dart';
import 'package:mtaa_frontend/webrtc/call_sample/call_sample.dart';

import '../UI/appbar.dart';
import '../constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  //SearchScreen({Key key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  static const routeName = '/settings-screen';
  var ipController = TextEditingController();

addIpAddress(context){
  showDialog(context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: TextField(
                      controller: ipController,
                      autocorrect: false,
                      enableSuggestions: false,
                      autofocus: false,
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: "Server IP Address",
                        hintStyle: const TextStyle(color: backgroundText, fontFamily: 'Roboto'),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                          child: Icon(Icons.text_snippet_outlined),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FloatingActionButton(
                        backgroundColor: primaryColor[300],
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => CallSample(host: ipController.text)));
                        },
                        
                        child: const Icon(
                          Icons.check_outlined,
                          color: Colors.white,
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: secondaryColor[300],
                        onPressed: () => Navigator.pop(context, false),
                        child: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          );
        });
      });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      bottomNavigationBar: myBottomAppBar(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: backgroundColor,
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
            TextButton(
              onPressed: () {
                //TODO add info
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text("Info",
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                ),
              ),
            ),
            ),
            TextButton(
                onPressed: () {
                  //TODO add webrtc call screen
                  addIpAddress(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text("Call Support",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          alignment: Alignment.center,

                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: Container(

                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 10),
                                const Text("Are you sure you want to permanently delete your account?",
                                style: TextStyle(
                                  fontSize: 18,

                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: TextButton(
                                          onPressed: (){
                                              //TODO delete account
                                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SignInScreen()));
                                          },
                                          child: const Text("Yes",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: TextButton(
                                          onPressed: () => Navigator.pop(context, false),
                                          child: const Text("No",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
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