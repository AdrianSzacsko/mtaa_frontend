import 'dart:ffi';
import 'dart:html';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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


  Widget information(String type, String text, IconData icon){
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 20,),
            Icon(
              icon,
              color: primaryColor,
            ),
            const SizedBox(width: 20,),
            Text(type,
              style: const TextStyle(
                  fontSize: 20
              ),
            ),
            const SizedBox(width: 20,),
            Text(text,
              style: const TextStyle(
                  fontSize: 20
              ),
            ),
          ],
        ),
        const SizedBox(height: 15,),
      ],
    );
  }

  selectFile(context) {
    showDialog(context: context,
        builder: (context) {
          FilePickerResult? file;
          return Dialog(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  /*Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage:
                        Image.memory(file != null ? file.files.first.bytes:
                        (await rootBundle.load("assets/Images/profile-unknown.png")).buffer.asUint8List()).image,
                    ),
                  ),*/
                  
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text("Please insert an image"),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                      onPressed: () async {
                        final image = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['jpg','png'],
                        );
                        if (image == null) return;
                        file = image;
                        setState(() {});
                      },
                      child: const Text("Select image"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      bottomNavigationBar: myBottomAppBar(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: const [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/Images/profile-unknown.png"),
                      radius: 100,
                    ),
                    SizedBox(height: 20,),
                    Text("Marko Stahovec",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("Comments: 5",
                    style: TextStyle(
                      fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "   Informations:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              information("Email:","xstahovec@stuba.sk",Icons.mail_rounded),
              information("Study year:","2",Icons.book_outlined),
              information("Register date:","2022.02.11",Icons.vpn_key_rounded),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  selectFile(context);
                },
                child: Container(
                  //alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 7, color: primaryColor),
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text("Modify picture",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}