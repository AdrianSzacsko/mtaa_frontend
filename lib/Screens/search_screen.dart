import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mtaa_frontend/Models/Professor.dart';
import 'package:mtaa_frontend/Screens/professor_screen.dart';
import 'package:mtaa_frontend/Screens/profile_page.dart';
import 'package:mtaa_frontend/Screens/profile_screen.dart';
import 'package:mtaa_frontend/Screens/subject_screen.dart';
//import 'package:flutter/rendering.dart';
import 'package:mtaa_frontend/UI/inputField.dart';
import 'package:mtaa_frontend/Screens/sign_in_screen.dart';
import 'package:mtaa_frontend/Screens/settings_screen.dart';
import 'package:mtaa_frontend/UI/loading_screen.dart';
import 'package:mtaa_frontend/key.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Models/Subject.dart';
import '../Models/prof.dart';
import '../Models/profile.dart';
import '../Models/search.dart';
import '../Models/User.dart';
import '../Models/subj.dart';
import '../Responses/Professor/respGetProfessor.dart';
import '../Responses/Subject/respGetSubject.dart';
import '../Responses/User/respGetMyUser.dart';
import '../UI/appbar.dart';
import '../constants.dart';


import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class SearchScreen extends StatefulWidget {
  //SearchScreen({Key key}) : super(key: key);
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  bool _isloadingLine = false;
  bool _isloadingCircle = false;

  ScrollController scrollController = ScrollController();

  static const routeName = '/search-screen';
  final searchController = TextEditingController();
  //List<String> row = <String>['name','code','id'];
  List<List<String>> list_of_rows = <List<String>>[];

  bool _isinitstate = true;

  final channel = IOWebSocketChannel.connect(Uri.parse(urlwbkey + "search/wb"));


  @override
  void initState() {
    super.initState();
    //dataLoadFunctionLine();
  }

  dataLoadFunctionLine() async {
    setState(() {
      _isloadingLine = true;
    });
    print(searchController);
    var resp;
    if (_isinitstate){
      resp = await Search().search("default_value");
      _isinitstate = false;
    }
    else {
      resp = await Search().search(searchController.text);
    }

    list_of_rows.clear();
    resp?.data.forEach((item){
      list_of_rows.add([item["name"].toString(), item["code"].toString(), item["id"].toString()]);
      print(item);
    });

    print(list_of_rows);
    setState(() {
      _isloadingLine = false;
    });
  }

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


  Widget buildList() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height -313,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding / 2),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: defaultPadding / 4);
            },
            scrollDirection: Axis.vertical,
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding * 1.5,
                defaultPadding, defaultPadding * 1.5),
            key: UniqueKey(),
            itemCount: list_of_rows.length,
            itemBuilder: (context, item) {

              return _buildRow(list_of_rows[item], item);
            },
          ),
        ),
      )

    );
  }

  BouncingScrollPhysics bouncingScrollPhysics = BouncingScrollPhysics();

  Widget _buildRow(List<String> row, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 10,
      shadowColor: index % 2 == 1 ? primaryColor[300] : secondaryColor[300],
      child: Padding (
        padding: const EdgeInsets.all(defaultPadding / 4),
        child: ListTile(
            title: Text(row[0], style: const TextStyle(fontSize: 18.0, color: mainTextColor)),
            trailing: Icon(row[1] == 'PROF' ? Icons.work_rounded :
            row[1] == 'USER' ? Icons.account_circle_rounded :
            Icons.article_rounded,
                color: index % 2 == 1 ? primaryColor[300] : secondaryColor[300]),

            onTap: () async {
              setState(() {
                _isloadingCircle = true;
              });
              if (row[1] == "USER") {
                var myUser = await respGetMyUser(int.parse(row[2]), context);

                if (myUser != null) {
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

              }
              else if (row[1] == "PROF") {
                var professor = await respGetProfessor(row[2], context);
                if (professor != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfessorScreen(),
                      // Pass the arguments as part of the RouteSettings. The
                      // DetailScreen reads the arguments from these settings.
                      settings: RouteSettings(
                        arguments: professor,
                      ),
                    ),
                  );
                }
              }
              else {
                var subject = await respGetSubject(row[2], context);

                if (subject != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubjectScreen(),
                      // Pass the arguments as part of the RouteSettings. The
                      // DetailScreen reads the arguments from these settings.
                      settings: RouteSettings(
                        arguments: subject,
                      ),
                    ),
                  );
                }
              }
              setState(() {
                _isloadingCircle = false;
              });
            }
        ),
      ),
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

  showSnackBar(String text, Color? color) {
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: myAppBar(context),
        bottomNavigationBar: myBottomAppBar(context),
        resizeToAvoidBottomInset : false,
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
          //alignment: _isloadingCircle? Alignment.center : Alignment.topCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //color: backgroundColor,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(5.0),
                    child: userInput(searchController, context),
                  ),
                  Container(
                    //height: 200,
                    child: Align(
                      alignment: Alignment.center,
                      //alignment: Alignment.topCenter,
                      child: FloatingActionButton(
                        heroTag: null,
                        backgroundColor: secondaryColor[300],
                        elevation: 10,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        onPressed: sendData,
                        /*onPressed: () async {
                          setState(() {
                            _isloadingLine = true;
                          });
                          print(searchController);
                          var response = await Search().search(searchController.text);

                          if (response == null) {
                            responseBar("There was en error during execution. Check your connection.", secondaryColor);
                          }
                          else {
                            if (response.statusCode == 200) {
                              //responseBar("Login successful", primaryColor);
                              list_of_rows.clear();
                              response.data.forEach((item){
                                list_of_rows.add([item["name"].toString(), item["code"].toString(), item["id"].toString()]);
                                print(item);
                              });

                              print(list_of_rows);
                              searchController.text = '';
                              //Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
                            }
                            else if (response.statusCode == 401) {
                              responseBar("You are not authorized to perform this action.", secondaryColor);
                            }
                            else if (response.statusCode == 404) {
                              responseBar("No such profile.", secondaryColor);
                            }
                            else if (response.statusCode! >= 500) {
                              responseBar("There is an error on server side, sit tight...", secondaryColor);
                            }
                            else {
                              responseBar("There was en error during execution.", secondaryColor);
                            }
                          }

                          setState(() {
                            _isloadingLine = false;
                          });
                        },*/
                        child: const Icon(
                          Icons.search_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Container(
                    alignment: Alignment.center,
                    child: Align(
                      alignment: Alignment.center,
                      child: StreamBuilder(
                        stream: channel.stream,
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.data != null) {
                            list_of_rows.clear();
                            //print(jsonDecode(snapshot.data));
                            var list = json.decode(json.decode(snapshot.data.toString()));
                            list.forEach((item){
                              list_of_rows.add([item["name"].toString(), item["code"].toString(), item["id"].toString()]);
                              //print(item);
                            });
                          }
                          print("building list");
                          return buildList();
                        },

                      ),
                      //buildList(),
                    ),
                  ),
                ],
              ),
            ),
            linearLoadingScreen(_isloadingLine),
            circularLoadingScreen(_isloadingCircle),
          ],
        ),
        ),
      ),
      onWillPop: () async {
        bool? result= await dialogConfirmation(context, "Log Out",
            "Are you sure you want to log out?");
        if(result == null){
          result = false;
        }
        else if (result == true) {
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(builder: (BuildContext context) => const SignInScreen()),
            ModalRoute.withName('/'),
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear();
          showSnackBar("Log Out Successful", primaryColor[300]);
        }
        return result;
      },
    );
  }

  void sendData() {
    print("sending");
      channel.sink.add(searchController.text);
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

}