import 'package:flutter/material.dart';
import 'package:mtaa_frontend/Responses/User/respDeleteMyUser.dart';
import 'package:mtaa_frontend/Screens/sign_in_screen.dart';
import 'package:mtaa_frontend/UI/responseBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/profile.dart';
import '../UI/appbar.dart';
import '../constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../webrtc/call_sample/call_sample.dart';
import 'info_screen.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  IconData leadingIcon = Icons.settings_outlined;
  var ipController = TextEditingController();
  bool isIpValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: myAppBar(context),
        bottomNavigationBar: myBottomAppBar(context),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => buildBody(),
                childCount: 1,
              ),
            )
          ],
        )
    );
  }

  bool validateIpAddress(String text) {
    final ip = RegExp(r'^(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))$');
    if (text.isEmpty) {
      setState(() {
        isIpValid = false;
      });
      return false;
    }
    if (ip.hasMatch(text)) {
      setState(() {
        isIpValid = true;
      });
      return true;
    }
    return false;
  }

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
                        child: TextFormField(
                          controller: ipController,
                          autocorrect: false,
                          enableSuggestions: false,
                          autofocus: false,
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(hintText: "Server IP Address",
                            errorText: isIpValid ? 'IP' : null,
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
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FloatingActionButton(
                            heroTag: null,
                            backgroundColor: primaryColor[300],
                            onPressed: () {
                              validateIpAddress(ipController.text);

                              if (isIpValid) {
                                isIpValid = false;
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => CallSample(host: ipController.text)));
                              }
                              else {
                                isIpValid = false;
                                responseBar("Invalid IP address", secondaryColor[300], context);
                              }
                            },

                            child: const Icon(
                              Icons.check_outlined,
                              color: Colors.white,
                            ),
                          ),
                          FloatingActionButton(
                            heroTag: null,
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

  Widget buildBody() {
    return
      SingleChildScrollView(
        padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding,
            top: defaultPadding * 2),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            elevation:10,
            shadowColor: secondaryColor[300],
            child: Column(
              children: <Widget>[
                GestureDetector(
                    //onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding / 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: secondaryColor.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(
                        leadingIcon,
                        size: 92,
                        color: primaryColor,
                      ),
                    ),

                ),
                //const SizedBox(height: defaultPadding,),
              ],
            ),),

            const SizedBox(height: defaultPadding * 2),
            SettingItem(title: "Info", leadingIcon: Icons.local_mall_outlined, leadingIconColor: (primaryColor[300])!,
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const InfoScreen()));
                }
            ),
            const SizedBox(height: defaultPadding / 1.75),
            SettingItem(title: "Call Support", leadingIcon: Icons.call, leadingIconColor: (secondaryColor[300])!,
                onTap: (){
                  addIpAddress(context);
                }
            ),
            const SizedBox(height: defaultPadding / 1.75),
            SettingItem(title: "Sign Out", leadingIcon: Icons.logout_outlined, leadingIconColor: (tertiaryColor[300])!,
              onTap: () async {
                var res = await dialogConfirmation(context, "Log Out",
                    "Are you sure you want to log out?");
                if (res == true) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(builder: (BuildContext context) => const SignInScreen()),
                    ModalRoute.withName('/'),
                  );
                  futureQueue.deleteQueue();
                  responseBar("Log Out Successful", primaryColor[300], context);
                }
              }
            ),
            const SizedBox(height: defaultPadding / 1.75),
            SettingItem(title: "Delete Account", leadingIcon: Icons.delete_outlined, leadingIconColor: Colors.grey.shade400,
              onTap: () async {
                var res = await dialogConfirmation(context, "Delete account",
                  "Are you sure you want to delete your account?");
                if (res == true) {
                  bool response = await respDeleteMyUser(context);
                  if (response){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const SignInScreen()));
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                  }
                }
              }
            ),
            const SizedBox(height: defaultPadding / 1.75),
          ],
        ),
      );
  }

  showConfirmLogout(){
    showCupertinoModalPopup(
        context: context,
        builder: (context) =>
            CupertinoActionSheet(
                message: Text("Would you like to sign out?"),
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: (){

                    },
                    child: const Text("Sign Out", style: TextStyle(color: secondaryColor),),
                  )
                ],
                cancelButton:
                CupertinoActionSheetAction(child:
                Text("Cancel"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
            )
    );
  }

  static Future<bool> dialogConfirmation(
      BuildContext context,
      String title,
      String content, {
        String textNo = 'No',
        String textYes = 'Yes',
      }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          alignment: Alignment.center,
          title: Text(title, textAlign: TextAlign.center),
          content: Text(content, textAlign: TextAlign.center),
          actions: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: null,
                      elevation: 10,
                      backgroundColor: primaryColor[300],
                      splashColor: secondaryColor[300],
                      onPressed: () => Navigator.pop(context, true),
                      child: const Icon(
                        Icons.check_outlined,
                        color: Colors.white,
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      elevation: 10,
                      backgroundColor: secondaryColor[300],
                      splashColor: primaryColor[300],
                      onPressed: () => Navigator.pop(context, false),
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}

class SettingItem extends StatelessWidget {
  final IconData? leadingIcon;
  final Color leadingIconColor;
  final String title;
  final GestureTapCallback? onTap;
  const SettingItem({ Key? key, required this.title, this.onTap, this.leadingIcon,
    this.leadingIconColor = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation:10,
          shadowColor: leadingIconColor,
          child: Container(
            padding: const EdgeInsets.only(left: defaultPadding, top: 8, bottom: 8, right: defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: leadingIcon != null ?
              [
                Container(
                  padding: const EdgeInsets.all(defaultPadding / 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: leadingIconColor.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Icon(
                    leadingIcon,
                    size: 23,
                    color: leadingIconColor,
                  ),
                ),
                const SizedBox(width: defaultPadding,),
                Expanded(
                  child: Text(
                    title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500 ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: backgroundText,
                  size: 14,
                )
              ]
                  :
              [
                Expanded(
                  child: Text(
                    title,  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500 ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: backgroundText,
                  size: 14,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}