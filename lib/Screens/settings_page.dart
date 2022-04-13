import 'package:flutter/material.dart';

import '../UI/appbar.dart';
import '../constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

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

  Widget buildBody() {
    return
      SingleChildScrollView(
        padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding,
            top: defaultPadding / 2),
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(defaultPadding * 2,
                      defaultPadding * 2, defaultPadding * 2,
                      defaultPadding),
                  child: Align(
                    alignment: Alignment.topCenter,
                      child: Image.asset('assets/Images/puzzle.png',
                        height: 80.0,
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
                const SizedBox(height: defaultPadding,),
              ],
            ),

            const SizedBox(height: defaultPadding),
            SettingItem(title: "My Orders", leadingIcon: Icons.local_mall_outlined, leadingIconColor: (primaryColor[300])!,
                onTap: (){

                }
            ),
            const SizedBox(height: defaultPadding / 2),
            SettingItem(title: "Favorites", leadingIcon: Icons.favorite, leadingIconColor: (secondaryColor[300])!,
                onTap: (){

                }
            ),
            const SizedBox(height: defaultPadding / 2),
            SettingItem(title: "Appearance", leadingIcon: Icons.dark_mode_outlined, leadingIconColor: (tertiaryColor[300])!,
                onTap: (){

                }
            ),
            const SizedBox(height: defaultPadding / 2),
            SettingItem(title: "Sign Out", leadingIcon: Icons.logout_outlined, leadingIconColor: Colors.grey.shade400,
              onTap: (){
                showConfirmLogout();
              },
            ),
            const SizedBox(height: defaultPadding / 2),
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
                  color: primaryColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
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