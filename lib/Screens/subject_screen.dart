import 'package:flutter/material.dart';
import 'package:mtaa_frontend/Screens/profile_page.dart';
import 'package:mtaa_frontend/Screens/subject_review_screen.dart';
import 'package:mtaa_frontend/UI/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Subject.dart';
import '../Models/User.dart';
import '../Models/profile.dart';
import '../Models/subj.dart';
import '../Responses/Subject/respDeleteSubjectReview.dart';
import '../Responses/Subject/respGetSubject.dart';
import '../Responses/User/respGetMyUser.dart';
import '../UI/loading_screen.dart';
import '../constants.dart';

import 'edit_subject_review_screen.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  bool _isloading = false;
  List<Widget> allReviews = List<Widget>.empty(growable: true);
  num averageDifficulty = 0;
  num averageUsability = 0;
  num averageProf = 0;

  Widget buildImage() {
    return Column(
      children: [
        Align(
            child: Image.asset('assets/Images/puzzle.png',
              height: 80.0,
              fit: BoxFit.cover,
            )
        ),
      ],
    );
  }
/*
  Widget buildImage() {
    const image = NetworkImage('https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80');

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
  }*/


  Widget buildName(String name) => Column(
    children: [
      Align(
        alignment: Alignment.topCenter,
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      const SizedBox(height: 4),
    ],
  );


  Widget buildInfo(String difficulty, String usability, String prof_avg) => Container(
    padding: const EdgeInsets.symmetric(),
    child: Column(
        children: [
          Divider(thickness: 2, color: secondaryColor[300]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.more_time_outlined,
                color: primaryColor,
              ),
              const SizedBox(width: defaultPadding / 2),
              const Align(
                alignment: Alignment.bottomRight,
                child: Text("Difficulty: ",
                  style: TextStyle(fontSize: 16,),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(difficulty + " /100",
                  style: TextStyle(fontSize: 16,),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.leaderboard_outlined,
                color: primaryColor,
              ),
              const SizedBox(width: defaultPadding / 2),
              const Align(
                alignment: Alignment.bottomRight,
                child: Text("Usability: ",
                  style: TextStyle(fontSize: 16,),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(usability + " /100",
                  style: TextStyle(fontSize: 16,),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.man_outlined,
                color: primaryColor,
              ),
              const SizedBox(width: defaultPadding / 4),
              const Align(
                alignment: Alignment.bottomRight,
                child: Text("Professor score: ",
                  style: TextStyle(fontSize: 16,),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(prof_avg + " /100",
                  style: TextStyle(fontSize: 16,),
                ),
              ),
            ],
          ),
        ]
    ),
  );


  Widget buildButton(String difficulty, String usability, String prof_avg) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildInfo(difficulty, usability, prof_avg)
          ],
        ),
      );


  Future<List<Widget>> makeWidgets(List<List<String>> reviews) async {
    //List<Widget> widgets = List<Widget>.empty(growable: true);
    for (var item in reviews) {
      var myUser = await respGetMyUser(int.parse(item[1]), context);

      if (myUser == null) {
        continue;
      }
      //var pic = await Profile().getProfilePic(item[0].toString());
      averageDifficulty = averageDifficulty + int.parse(item[3]);
      averageUsability = averageUsability + int.parse(item[4]);
      averageProf = averageProf + int.parse(item[5]);

      allReviews.add(SubjectReview(
        subj_id: int.parse(item[0]),
        user_id: int.parse(item[1]),
        name: myUser.name,
        description: item[2],
        difficulty: int.parse(item[3]),
        usability: int.parse(item[4]),
        prof_avg: int.parse(item[5]),
        image: myUser.image ?? const AssetImage("assets/Images/profile-unknown.png"),
      ));
    }
    print(allReviews);
    //setState(() {});
    return allReviews;
  }


  @override
  Widget build(BuildContext context) {

    final subject = ModalRoute.of(context)!.settings.arguments as Subject;

    return Scaffold(
        appBar: myAppBar(context),
        bottomNavigationBar: myBottomAppBar(context),
        body: FutureBuilder(
          future: makeWidgets(subject.reviews),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return circularLoadingScreen(true);
            } else {
              circularLoadingScreen(false);
            }

            return ListView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(defaultPadding / 6, defaultPadding / 2,
                  defaultPadding / 6, defaultPadding / 2),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    elevation:10,
                    shadowColor: primaryColor[300],
                    child: Column(
                      children: [
                        const SizedBox(height: defaultPadding * 2),
                        Center(
                          child: Stack(
                            children: [
                              buildImage(),
                            ],
                          ),
                        ),
                        const SizedBox(height: defaultPadding * 2),
                        buildName(subject.name),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildButton(averageDifficulty != 0 ? ((averageDifficulty ~/ allReviews.length).toString()) : "50",
                                averageUsability != 0 ? ((averageUsability ~/ allReviews.length).toString()) : "50",
                                averageProf != 0 ? ((averageProf ~/ allReviews.length).toString()) : "50"),
                          ],
                        ),
                        const SizedBox(height: defaultPadding * 2),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(defaultPadding * 2,
                          defaultPadding * 2, defaultPadding * 2,
                          0),
                      child: Text(
                        'Reviews',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(defaultPadding * 2,
                          defaultPadding * 2, defaultPadding * 2,
                          0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          heroTag: null,
                          elevation: 10,
                          backgroundColor: secondaryColor[300],
                          splashColor: primaryColor[300],
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SubjectReviewScreen(subj_id: subject.subj_id,)));
                          },
                          child: const Icon(
                            Icons.add_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(children: [
                  for ( var item in allReviews ) item,
                ],)
              ],
            );
          }
        )
    );
  }
}

class SubjectReview extends StatefulWidget {
  final int subj_id;
  final int user_id;
  final String name;
  final String description;
  final int difficulty;
  final int usability;
  final int prof_avg;
  final ImageProvider image;
  const SubjectReview({Key? key, required this.subj_id, required this.user_id, required this.name, required this.description,
    required this.difficulty, required this.usability, required this.prof_avg, required this.image}) : super(key: key);

  @override
  SubjectReviewState createState() => SubjectReviewState();
}


class SubjectReviewState extends State<SubjectReview> {
  var _isloading = false;
  Widget buildInfo(String value) => Container(
    padding: const EdgeInsets.symmetric(),
    child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.bottomRight,
                child: Text("Rating: ",
                  style: TextStyle(fontSize: 14,),
                ),
              ),
              const Icon(
                Icons.star_outlined,
                color: primaryColor,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(value,
                  style: TextStyle(fontSize: 14,),
                ),
              ),
            ],
          )
        ]
    ),
  );

  setLoadingScreenNavigator(context) async {
    //TODO loadingscreen
    setState(() {
      _isloading = true;
    });
    var myUser = await respGetMyUser(widget.user_id, context);

    if (myUser != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ProfilePage(),
        settings: RouteSettings(
          arguments: myUser,
        ),
      ));
    }
    setState(() {
      _isloading = false;
    });
  }


  Future<bool> userIdMatch(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final user_id = prefs.getInt('user_id') ?? '';

    if (user_id == id) {
      return true;
    }

    return false;
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
                padding: EdgeInsets.fromLTRB(0, 0, 0, defaultPadding),
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


  void revertState(BuildContext context, String subj_id) async {
    var subject = await respGetSubject(subj_id, context);

    if (subject != null) {
      Navigator.pop(context);
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


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: userIdMatch(widget.user_id),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return circularLoadingScreen(true);
        } else {
          circularLoadingScreen(false);
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: GestureDetector(
            onLongPress: () async {
              bool areIdsMatching = await userIdMatch(widget.user_id);
              if (areIdsMatching == true) {
                var res = await dialogConfirmation(context, "Delete review",
                    "Are you sure you want to delete your review?");
                if (res == true) {
                  var resp = await respDeleteSubjectReview(widget.user_id.toString(), widget.subj_id.toString(), context);
                  if (resp) {
                    revertState(context, widget.subj_id.toString());
                  }
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation:10,
                  shadowColor: primaryColor[300],
                  child: Stack (
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: CircleAvatar(
                                backgroundImage: widget.image,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      primary: Colors.transparent
                                  ),
                                  onPressed: () {setLoadingScreenNavigator(context);},
                                  child: null,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(0,defaultPadding / 2,defaultPadding / 2,defaultPadding / 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      if (snapshot.data == true)
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: SizedBox.fromSize(
                                              size: Size(28, 28), // button width and height
                                              child: FloatingActionButton(
                                                heroTag: null,
                                                elevation: 10,
                                                backgroundColor: secondaryColor[300],
                                                splashColor: primaryColor[300],
                                                onPressed: (){
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => EditSubjectReviewScreen(subj_id: widget.subj_id.toString(),
                                                    message: widget.description, difficulty: widget.difficulty.toString(), usability: widget.usability.toString(),
                                                    prof_avg: widget.prof_avg.toString(),)));
                                                },
                                                child: const Icon(
                                                  Icons.edit_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      Text(
                                          widget.name, style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16,
                                      )
                                      ),
                                      Text(widget.description, style: const TextStyle(fontSize: 14)),
                                      _SubjectScreenState().buildInfo(widget.difficulty.toString(),
                                          widget.usability.toString(),widget.prof_avg.toString()),
                                    ],
                                  ),
                              ),
                          ),
                        ]
                      ),
                      circularLoadingScreen(_isloading),
                    ],
                  )
              ),
            ),
          ),
        );
      }
    );
  }
}
