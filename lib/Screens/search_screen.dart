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
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Subject.dart';
import '../Models/prof.dart';
import '../Models/profile.dart';
import '../Models/search.dart';
import '../Models/User.dart';
import '../Models/subj.dart';
import '../UI/appbar.dart';
import '../constants.dart';

class SearchScreen extends StatefulWidget {
  //SearchScreen({Key key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  bool _isloading = false;

  ScrollController scrollController = ScrollController();

  static const routeName = '/search-screen';
  final searchController = TextEditingController();
  //List<String> row = <String>['name','code','id'];
  List<List<String>> list_of_rows = <List<String>>[];


  @override
  void initState() {
    super.initState();
    dataLoadFunction();
  }

  dataLoadFunction() async {
    setState(() {
      _isloading = true;
    });
    print(searchController);
    //await Future.delayed(const Duration(seconds: 2));
    var resp = await Search().search(searchController.text);
    //print(resp.runtimeType);

    list_of_rows.clear();
    resp?.forEach((item){
      list_of_rows.add([item["name"].toString(), item["code"].toString(), item["id"].toString()]);
      print(item);
    });

    print(list_of_rows);
    // list_of_rows.add(['Marko Stahovec','USER','5']);
    setState(() {
      _isloading = false;
    });
  }


  Widget buildList() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height -276,
      child: Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(defaultPadding),
          key: UniqueKey(),
          itemCount: list_of_rows.length,
          itemBuilder: (context, item) {

            return _buildRow(list_of_rows[item]);
          },
        ),
      )

    );
  }

  BouncingScrollPhysics bouncingScrollPhysics = BouncingScrollPhysics();

  Widget _buildRow(List<String> row) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding (
        padding: EdgeInsets.all(5),
        child: ListTile(
            title: Text(row[0], style: TextStyle(fontSize: 18.0, color: mainTextColor)),
            trailing: Icon(row[1] == 'PROF' ? Icons.work_rounded :
            row[1] == 'USER' ? Icons.account_circle_rounded :
            Icons.article_rounded,
                color: primaryColor[300]),

            onTap: () async {
              if (row[1] == "USER") {
                var resp = await Profile().getProfile(row[2]);
                print(resp);

                var resp2 = await Profile().getProfilePic(row[2]);

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
              }
              else if (row[1] == "PROF") {
                var resp = await ProfessorClass().getProfessor(row[2]);
                print(resp);
                var resp2 = await ProfessorClass().getProfessorReviews(row[2]);

                List<List<String>> allReviews = <List<String>>[];
                resp2?.forEach((item) {
                  //var author = await Profile().getProfile(item["user_id"].toString());
                  allReviews.add([item["id"].toString(), item["user_id"].toString(),
                    item["message"].toString(), item["rating"].toString()]);
                  //print(item);
                });


                var professor = Professor(
                  prof_id: row[2],
                  name: resp[0]["name"],
                  reviews: allReviews,
                );

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
              else {
                var resp = await SubjectClass().getSubject(row[2]);
                print(resp);
                List<String> allProfessors = <String>[];
                resp?.forEach((item) {
                  allProfessors.add(item["teachers"]);
                });

                var resp2 = await SubjectClass().getSubjectReviews(row[2]);
                print("*********************************");
                print(resp2);
                print("*********************************");

                List<List<String>> allReviews = <List<String>>[];
                resp2?.forEach((item) {
                  allReviews.add([item["id"].toString(),
                    item["user_id"].toString(),
                    item["message"].toString(), item["difficulty"].toString(),
                    item["usability"].toString(), item["prof_avg"].toString()]);
                });

                print(allReviews);

                var subject = Subject(
                  subj_id: row[2],
                  name: resp[0]["name"],
                  professors: allProfessors,
                  reviews: allReviews,
                );

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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      bottomNavigationBar: myBottomAppBar(context),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: backgroundColor,
            child: Column(
              children: [
                Container(
                  height: 100,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.all(5.0),
                  child: Align(
                    child: Form(
                      child: userInput(searchController, //Calling inputField  class
                          const Icon(
                            Icons.search_outlined,
                            color: backgroundText,
                          ),
                          "Search..."),
                    ),
                  ),
                ),
                  Container(
                    //height: 200,
                    child: Align(
                      alignment: Alignment.center,
                      //alignment: Alignment.topCenter,
                      child: FloatingActionButton(
                        backgroundColor: secondaryColor[300],
                        elevation: 10,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        onPressed: () {
                          setState(() {
                            dataLoadFunction();
                          });
                          print(searchController.text);
                          searchController.text = '';
                        },
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
                      child: buildList(),
                    ),
                  ),
                ],
              ),
            ),
            linearLoadingScreen(_isloading),
          ],
        ),
    );
  }
}