import 'package:flutter/material.dart';
import 'package:mtaa_frontend/Models/Professor.dart';
import 'package:mtaa_frontend/Screens/settings_screen.dart';
import 'package:mtaa_frontend/UI/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Subject.dart';
import '../Models/profile.dart';
import '../constants.dart';
import '../Screens/profile_page.dart';

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
      var author = await Profile().getProfile(item[0].toString());
      //var pic = await Profile().getProfilePic(item[0].toString());
      averageDifficulty = averageDifficulty + int.parse(item[2]);
      averageUsability = averageUsability + int.parse(item[3]);
      averageProf = averageProf + int.parse(item[4]);
      print("9999999999999999999999999999999999");
      print(item);
      print("8888888888888888888888888888888888");
      print(author);
      print("7777777777777777777777777777777777");
      allReviews.add(SubjectReview(
        id: int.parse(item[0]),
        name: author[0]["name"],
        description: item[1],
        difficulty: int.parse(item[2]),
        usability: int.parse(item[3]),
        prof_avg: int.parse(item[4]),
        image: "puzzle.png",
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
            if (snapshot.data == null) return CircularProgressIndicator();

            return ListView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
              children: <Widget>[
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(defaultPadding * 2,
                          defaultPadding * 2, defaultPadding * 2,
                          defaultPadding),
                      child: Text(
                        'Reviews',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(defaultPadding * 2,
                          defaultPadding * 2, defaultPadding * 2,
                          defaultPadding),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox.fromSize(
                          size: Size(56, 56), // button width and height
                          child: ClipOval(
                            child: Material(
                              color: secondaryColor[300], // button color
                              child: InkWell(
                                splashColor: primaryColor[300], // splash color
                                onTap: () {}, // button pressed
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Icon(Icons.add_outlined), // icon
                                    //Text("Add"), // text
                                  ],
                                ),
                              ),
                            ),
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


class SubjectReview extends StatelessWidget {
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

  Future<bool> userIdMatch(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final user_id = prefs.getInt('user_id') ?? '';

    if (user_id == id) {
      return true;
    }

    return false;
  }

  SubjectReview({required this.id, required this.name, required this.description,
    required this.difficulty, required this.usability, required this.prof_avg, required this.image});
  final int id;
  final String name;
  final String description;
  final int difficulty;
  final int usability;
  final int prof_avg;
  final String image;
  @override
  Widget build(BuildContext context) {
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
              bool areIdsMatching = await userIdMatch(id);
              if (areIdsMatching == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              }
            },
            child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation:5,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                      child: Image.asset('assets/Images/' + image,
                        height: 80.0,
                        fit: BoxFit.cover,
                      )
                  ),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(defaultPadding / 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                  name, style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,
                              )
                              ),
                              Text(description, style: const TextStyle(fontSize: 14)),
                              _SubjectScreenState().buildInfo(difficulty.toString(),
                                  usability.toString(),prof_avg.toString()),
                            ],
                          )
                      )
                  )
                ]
            )
        )),
    );
  }
}


class SubjectReviewScreen extends StatefulWidget {
  const SubjectReviewScreen({Key? key}) : super(key: key);

  @override
  _SubjectReviewScreenState createState() => _SubjectReviewScreenState();
}

class _SubjectReviewScreenState extends State<SubjectReviewScreen> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}