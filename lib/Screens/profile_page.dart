import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/User.dart';
import '../Models/profile.dart';
import '../UI/appbar.dart';
import '../constants.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late ImageProvider file;
  late ImageProvider newFile;
  late Uint8List newFileBytes;

  Future<bool> userIdMatch(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final user_id = prefs.getInt('user_id') ?? '';

    if (user_id == id) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    // final user = UserPreferences.myUser;
    final user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      backgroundColor: backgroundColor,
          appBar: myAppBar(context),
          bottomNavigationBar: myBottomAppBar(context),
          body: FutureBuilder<bool>(
              future: userIdMatch(user.user_id),
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return const CircularProgressIndicator();
                return ListView(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(defaultPadding / 2, defaultPadding / 2,
                      defaultPadding / 2, defaultPadding / 2
                  ),
                  children: [
                    //const SizedBox(height: defaultPadding * 2),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        elevation:10,
                        shadowColor: primaryColor[300],
                        child:
                        Column(
                          children: [
                        Center(
                        child:
                        Padding(
                          padding: const EdgeInsets.only(top: defaultPadding * 2),
                          child: Stack(
                            children: [
                              const SizedBox(height: defaultPadding * 2,),
                              buildImage(user),
                              if (snapshot.data == true)
                                Positioned(
                                  bottom: 0,
                                  right: 4,
                                  child: buildEditIcon(secondaryColor),
                                ),
                            ],
                          ),
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
                               const SizedBox(height: defaultPadding),
                          ],
                        ),
                    ),),
                        //const SizedBox(height: defaultPadding * 2),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(defaultPadding * 2,
                              defaultPadding * 1.5, defaultPadding * 2,
                              defaultPadding),
                          child: Text(
                            'Informations',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    elevation:10,
                    shadowColor: primaryColor[300],
                    child: buildInfo(user),
                ),
                ),
                  ],
                );
                }
                ),
    );
  }

  Widget buildImage(User user) {
    //ImageProvider<Object> image = const AssetImage("assets/Images/profile-unknown.png");
    file = user.image;
    newFile = user.image;

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: user.image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          // child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  ImageProvider returnImage(){
    if (newFile == null) {
      return const AssetImage("assets/Images/profile-unknown.png");
    }
    else {
      //return Image.file(File(file.files.first.path.toString())).image;
      //return Image.memory(Uint8List.fromList(file.files.first.bytes!.toList())).image;
      return newFile;
    }
  }


  void revertState(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final user_id = prefs.getInt('user_id') ?? '';

    var resp = await Profile().getProfile(user_id.toString());
    var resp2 = await Profile().getProfilePic(user_id.toString());

    //print(resp2.runtimeType);
    /*Uint8List(resp2);
            //final mime = lookupMimeType('', headerBytes: resp2);
            Latin1Encoder encoder = const Latin1Encoder();
            var bytes = encoder.convert(resp2);

            final codec = await instantiateImageCodec(bytes.buffer.asUint8List());
            final frameInfo = await codec.getNextFrame();
            //return frameInfo.image;*/

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

    Navigator.pop(context, false);
    Navigator.pop(context, false);
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


  selectFile(context) {
    showDialog(context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              alignment: Alignment.center,
              content: Container(
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
                    /*
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text("Please insert an image"),
                    ),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Container(
                            margin: const EdgeInsets.all(defaultPadding / 4),
                            child: FloatingActionButton(
                              heroTag: null,
                              backgroundColor: tertiaryColor[300],
                              onPressed: () async {
                                final image = await FilePicker.platform.pickFiles(
                                  withData: true,
                                  //type: FileType.custom,
                                  //allowedExtensions: ['jpg','png'],
                                );
                                if (image == null) return;
                                newFile = Image.memory(image.files.first.bytes!).image;
                                newFileBytes = image.files.first.bytes!;
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.add_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.all(defaultPadding / 4),
                              /*
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),*/
                              child: FloatingActionButton(
                                heroTag: null,
                                backgroundColor: secondaryColor[300],
                                onPressed: () {
                                  Profile().deleteProfilePic();
                                  /*
                              if (newFileBytes.isNotEmpty){
                                newFileBytes.clear();
                              }*/

                                  newFile = const AssetImage("assets/Images/profile-unknown.png");
                                  file = const AssetImage("assets/Images/profile-unknown.png");
                                  revertState(context);
                                } ,
                                child: const Icon(
                                  Icons.delete_outlined,
                                  color: Colors.white,
                                ),
                              )
                          ),

                        ],
                        ),

                    const SizedBox(height: defaultPadding * 2),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(defaultPadding / 8),/*
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),*/
                          child: FloatingActionButton(
                            heroTag: null,
                            backgroundColor: primaryColor[300],
                            onPressed: (){
                              if (file == newFile || newFileBytes.isEmpty) {
                              }
                              else {
                                Profile().putProfilePic(bytes: newFileBytes);
                              }

                              revertState(context);

                            },
                            child: const Icon(
                              Icons.check_outlined,
                              color: Colors.white,
                            ),
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
      color: color,
      all: 8,
      child: IconButton(
        padding: EdgeInsets.zero,
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