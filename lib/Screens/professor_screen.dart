import 'package:flutter/material.dart';
import 'package:mtaa_frontend/Models/Professor.dart';
import 'package:mtaa_frontend/Responses/Professor/respDeleteProfessorReview.dart';
import 'package:mtaa_frontend/Responses/Professor/respGetProfessor.dart';
import 'package:mtaa_frontend/Screens/edit_professor_review_screen.dart';
import 'package:mtaa_frontend/Screens/professor_review_screen.dart';
import 'package:mtaa_frontend/UI/appbar.dart';
import 'package:mtaa_frontend/UI/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/User.dart';
import '../Models/prof.dart';
import '../Models/profile.dart';
import '../Responses/User/respGetMyUser.dart';
import '../constants.dart';
import '../Screens/profile_page.dart';


class ProfessorScreen extends StatefulWidget {
  const ProfessorScreen({Key? key}) : super(key: key);

  @override
  _ProfessorScreenState createState() => _ProfessorScreenState();
}

class _ProfessorScreenState extends State<ProfessorScreen> {
  bool _isloading = false;
  List<Widget> allReviews = List<Widget>.empty(growable: true);
  num averageRating = 0;

  Widget buildImage() {
    const image = AssetImage("assets/Images/profile-unknown.png");

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

  Widget buildInfo(String value) => Container(
    padding: const EdgeInsets.symmetric(),
    child: Column(
      children: [
        Divider(thickness: 2, color: secondaryColor[300]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.star_outlined,
              color: primaryColor,
            ),
            const SizedBox(width: defaultPadding / 2),
            const Align(
              alignment: Alignment.bottomRight,
              child: Text("Score: ",
                style: TextStyle(fontSize: 16,),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(value + " /100",
                style: TextStyle(fontSize: 16,),
              ),
            ),
          ],
        )
      ]
    ),
  );

  Widget buildButton(String value) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildInfo(value)
          ],
        ),
      );

  /*
  loadData(List<dynamic> reviews) async {
    for (var item in reviews) {
      var author = await Profile().getProfile(item["user_id"].toString());
      ProfessorReview(
        name: item["user_id"].toString(),
        description: item["message"],
        rating: item["rating"],
        image: "puzzle.png",
      );
      setState(() {});
    }
  }*/


  Future<List<Widget>> makeWidgets(List<List<String>> reviews) async {
    //List<Widget> widgets = List<Widget>.empty(growable: true);
    for (var item in reviews) {
      var myUser = await respGetMyUser(int.parse(item[1]), context);

      if (myUser == null) {
        continue;
      }
      //var pic = await Profile().getProfilePic(item[0].toString());
      averageRating = averageRating + int.parse(item[3]);

      allReviews.add(ProfessorReview(
        prof_id: int.parse(item[0]),
        user_id: int.parse(item[1]),
        name: myUser.name,
        description: item[2],
        rating: int.parse(item[3]),
        image: myUser.image ?? const AssetImage("assets/Images/profile-unknown.png"),
      ));
    }
    print(allReviews);
    //setState(() {});
    return allReviews;
  }

  @override
  Widget build(BuildContext context) {

    final professor = ModalRoute.of(context)!.settings.arguments as Professor;

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: myAppBar(context),
        bottomNavigationBar: myBottomAppBar(context),
        body: FutureBuilder(
          future: makeWidgets(professor.reviews),
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
                        buildName(professor.name),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildButton(averageRating != 0 ? ((averageRating ~/ allReviews.length).toString()) : "50"),
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
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ProfessorReviewScreen(prof_id: professor.prof_id,)));
                            },
                            child: const Icon(
                              Icons.add_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),/*
                  ProfessorReview(
                    name: professor.reviews[0][0],
                    description: professor.reviews[0][1],
                    rating: int.parse(professor.reviews[0][2]),
                    image: "puzzle.png",
                  ),*/
                  Column(children: [
                    for ( var i in allReviews ) i,
                  ],)
                ],
            );
          },
        )
    );
  }
}

class ProfessorReview extends StatefulWidget {
  final int prof_id;
  final int user_id;
  final String name;
  final String description;
  final int rating;
  final ImageProvider image;
  const ProfessorReview({Key? key, required this.prof_id, required this.user_id, required this.name,
    required this.description, required this.rating, required this.image}) : super(key: key);
  @override
  ProfessorReviewState createState() => ProfessorReviewState();
}



class ProfessorReviewState extends State<ProfessorReview> {
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
                child: Text("Score: ",
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

  void revertState(BuildContext context, String prof_id) async {
    var professor = await respGetProfessor(prof_id, context);

    if (professor != null) {
      Navigator.pop(context);
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
                    var resp = await respDeleteProfessorReview(widget.user_id.toString(), widget.prof_id.toString(), context);
                    if (resp) {
                      revertState(context, widget.prof_id.toString());
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
                child: Stack(
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
                                  elevation: 0,
                                  shape: const CircleBorder(),
                                  primary: Colors.transparent,
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
                                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => EditProfessorReviewScreen(prof_id: widget.prof_id.toString(),
                                                message: widget.description, rating: widget.rating.toString())));
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
                                  _ProfessorScreenState().buildInfo(widget.rating.toString()),
                                ],
                              ),
                          ),
                      ),
                    ]
                  ),
                  circularLoadingScreen(_isloading),
                ]
              ),
            ),
          ),
        ),
      );
    }

    );
  }
}