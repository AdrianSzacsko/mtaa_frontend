import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Models/User.dart';
import '../Models/profile.dart';
import '../UI/appbar.dart';
import '../constants.dart';

/*
class UserPreferences {
  static const myUser = User(
    email: 'sarah.abs@gmail.com',
    name: 'Sarah Abs',
    comments:
    '5',
    reg_date: "2022-04-05",
    study_year: "2",
    image:
    'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
  );
}*/

/*
class ProfileWidget extends StatelessWidget {
  final Image image;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.image,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }
}*/

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  var file;

  @override
  Widget build(BuildContext context) {
    // final user = UserPreferences.myUser;
    final user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      backgroundColor: backgroundColor,
          appBar: myAppBar(context),
          bottomNavigationBar: myBottomAppBar(context),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(height: defaultPadding * 2),
              Center(
                child: Stack(
                  children: [
                    buildImage(user),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: buildEditIcon(primaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding * 2),
              buildName(user),
              const SizedBox(height: defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton(context, user.comments, 'Comments'),
                  buildVerticalDivider(),
                  buildButton(context, user.reg_date, 'Reg. Date'),
                ],
              ),
              const SizedBox(height: defaultPadding * 2),
              const Padding(
                  padding: EdgeInsets.fromLTRB(defaultPadding * 2,
                      defaultPadding * 2, defaultPadding * 2,
                      defaultPadding),
                  child: Text(
                    'Informations',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),),

              buildInfo(user),
            ],
          ),
    );
  }

  Widget buildImage(User user) {
    final image = NetworkImage(user.image);
    //final image = const NetworkImage('https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80');

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          // child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  ImageProvider returnImage(){
    if (file == null ||file.files.isEmpty) {
      return const AssetImage("assets/Images/profile-unknown.png");
    }
    else {
      //return Image.file(File(file.files.first.path.toString())).image;
      //return Image.memory(Uint8List.fromList(file.files.first.bytes!.toList())).image;
      return Image.memory(file.files.first.bytes!).image;
    }
  }


  selectFile(context) {
    showDialog(context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
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
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: returnImage(),
                        /*file == null ? const AssetImage("assets/Images/profile-unknown.png") :
                        Image.memory(file.files.first.bytes) as ImageProvider,*/
                        /*Image.memory(file != null ? file.files.first.bytes :
                        (await rootBundle.load("assets/Images/profile-unknown.png")).buffer.asUint8List()).image,*/
                      ),
                    ),

                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text("Please insert an image"),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(12),
                          ),
                        child: TextButton(

                        onPressed: () async {
                          final image = await FilePicker.platform.pickFiles(
                            withData: true,
                            //type: FileType.custom,
                            //allowedExtensions: ['jpg','png'],
                          );
                          if (image == null) return;
                          file = image;
                          setState(() {});
                          },
                        child: const Text("Select image", style: TextStyle(color: Colors.black),),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20,),

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
                                //TODO commit image
                                if (file == null ||file.files.isEmpty) {
                                  Navigator.pop(context, false);
                                }
                                else {
                                  print("sdfasf");
                                  print(file.files.first.bytes);
                                  Profile().putProfilePic(profile_id: '1', bytes: file.files.first.bytes);
                                  Navigator.pop(context, false);
                                }
                              },
                              child: const Text("Apply",
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
                              child: const Text("Abort",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
          });
        });
  }


  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: primaryColor,
      all: 8,
      child: IconButton(
        constraints: const BoxConstraints(maxHeight: 16, maxWidth: 16),
        onPressed: () {
          selectFile(context);
        },
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 16,
        ),
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  Widget buildVerticalDivider() => Container(
    height: 24,
    child: VerticalDivider(thickness: 2, color: secondaryColor[300]),
  );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      /*
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )*/
    ],
  );

  Widget information(String type, String text, IconData icon) => Container(
      child: Column(
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 20,),
            Text(text,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 15,),
      ],
    ),
  );

  Widget buildInfo(User user) => Container(
    decoration: const BoxDecoration(
      /*
      borderRadius: BorderRadius.circular(25.0),
      border: Border.all(
        color: primaryColor,
      ),

       */
    ),
    padding: const EdgeInsets.symmetric(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        information("Email:", user.email, Icons.mail_rounded),
        information("Study year:", user.study_year, Icons.book_outlined),
        information("Register date:", user.reg_date, Icons.vpn_key_rounded),
      ],
    ),
  );
}