import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mtaa_frontend/Screens/search_screen.dart';
import 'package:mtaa_frontend/Screens/subject_screen.dart';
import 'package:mtaa_frontend/UI/appbar.dart';

import '../Models/Subject.dart';
import '../Models/subj.dart';
import '../constants.dart';


class SubjectReviewScreen extends StatefulWidget {
  final String subj_id;
  String? message = "";
  String? difficulty = "";
  String? usability = "";
  String? prof_avg = "";

  SubjectReviewScreen({required this.subj_id, this.message,
  this.difficulty, this.usability, this.prof_avg});

  @override
  _SubjectReviewScreenState createState() => _SubjectReviewScreenState();
}

class _SubjectReviewScreenState extends State<SubjectReviewScreen> {
  var myFeedbackText = "COULD BE BETTER";
  late var difficultySlider = 0.0;
  late var usabilitySlider = 0.0;
  late var profSlider = 0.0;
  late var reviewController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void revertState(BuildContext context, String subj_id) async {
    var resp = await SubjectClass().getSubject(subj_id);
    print(resp);
    List<String> allProfessors = <String>[];
    resp?.forEach((item) {
      allProfessors.add(item["teachers"]);
    });

    var resp2 = await SubjectClass().getSubjectReviews(subj_id);
    //print("*********************************");
    //print(resp2);
    //print("*********************************");

    List<List<String>> allReviews = <List<String>>[];
    resp2?.forEach((item) {
      allReviews.add([item["id"].toString(),
        item["user_id"].toString(),
        item["message"].toString(), item["difficulty"].toString(),
        item["usability"].toString(), item["prof_avg"].toString()]);
    });

    //print(allReviews);

    var subject = Subject(
      subj_id: subj_id,
      name: resp[0]["name"],
      professors: allProfessors,
      reviews: allReviews,
    );

    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      bottomNavigationBar: myBottomAppBar(context),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height:defaultPadding),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Text("Subject Review",
                        style: TextStyle(color: Colors.black, fontSize: 22.0,fontWeight:FontWeight.bold),),
                    ),
                  ),
                  const SizedBox(height:defaultPadding / 2),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding),
                      child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: primaryColor[300],
                        child: Column(children: <Widget>[
                          /*
                          Padding(
                        padding: const EdgeInsets.all(defaultPadding / 4),
                        child: Container(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: StarWidget(),
                          ),
                        ),
                          ),*/
                          Padding(
                            padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Row(children: const [
                                          Icon(
                                            Icons.more_time_outlined,
                                            color: primaryColor,
                                          ),
                                          SizedBox(width: defaultPadding / 2),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text("Difficulty: ",
                                              style: TextStyle(fontSize: 16,),
                                            ),
                                          ),
                                        ],),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(difficultySlider.toStringAsFixed(0),
                                      style: TextStyle(fontSize: 16,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(child: Slider(
                              min: 0.0,
                              max: 100.0,
                              divisions: 100,
                              value: difficultySlider,
                              activeColor: primaryColor[300],
                              inactiveColor: secondaryColor[300],
                              onChanged: (newValue) {
                                setState(() {
                                  difficultySlider = newValue;
/*
                              if (sliderValue == 1.0 ) {
                                myFeedback1 = Icons.star_outlined;
                                myFeedbackColor1 = Colors.yellow;
                              }
                              else if (sliderValue < 1.0 ){
                                myFeedback1 = Icons.star;
                                myFeedbackColor1 = Colors.grey;

                              }
                              if (sliderValue == 2.0 ) {
                                myFeedback2 = Icons.star_outlined;
                                myFeedbackColor2= Colors.yellow;
                              }
                              else if (sliderValue < 2.0 ){
                                myFeedback2 = Icons.star;
                                myFeedbackColor2 = Colors.grey;

                              }
                              if (sliderValue == 3.0 ) {
                                myFeedback3 = Icons.star_outlined;
                                myFeedbackColor3 = Colors.yellow;
                              }
                              else if (sliderValue < 3.0 ){
                                myFeedback3 = Icons.star;
                                myFeedbackColor3 = Colors.grey;

                              }
                              if (sliderValue == 4.0 ) {
                                myFeedback4 = Icons.star_outlined;
                                myFeedbackColor4 = Colors.yellow;
                              }
                              else if (sliderValue < 4.0 ){
                                myFeedback4 = Icons.star;
                                myFeedbackColor4 = Colors.grey;

                              }
                              if (sliderValue == 5.0 ) {
                                myFeedback5 = Icons.star_outlined;
                                myFeedbackColor5 = Colors.yellow;
                              }
                              else if (sliderValue < 5.0 ){
                                myFeedback5 = Icons.star;
                                myFeedbackColor5 = Colors.grey;

                              }*/

                                });
                              },
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Row(children: const [
                                          Icon(
                                            Icons.leaderboard_outlined,
                                            color: primaryColor,
                                          ),
                                          SizedBox(width: defaultPadding / 2),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text("Usability: ",
                                              style: TextStyle(fontSize: 16,),
                                            ),
                                          ),
                                        ],),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(usabilitySlider.toStringAsFixed(0),
                                      style: TextStyle(fontSize: 16,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(child: Slider(
                              min: 0.0,
                              max: 100.0,
                              divisions: 100,
                              value: usabilitySlider,
                              activeColor: primaryColor[300],
                              inactiveColor: secondaryColor[300],
                              onChanged: (newValue) {
                                setState(() {
                                  usabilitySlider = newValue;
/*
                              if (sliderValue == 1.0 ) {
                                myFeedback1 = Icons.star_outlined;
                                myFeedbackColor1 = Colors.yellow;
                              }
                              else if (sliderValue < 1.0 ){
                                myFeedback1 = Icons.star;
                                myFeedbackColor1 = Colors.grey;

                              }
                              if (sliderValue == 2.0 ) {
                                myFeedback2 = Icons.star_outlined;
                                myFeedbackColor2= Colors.yellow;
                              }
                              else if (sliderValue < 2.0 ){
                                myFeedback2 = Icons.star;
                                myFeedbackColor2 = Colors.grey;

                              }
                              if (sliderValue == 3.0 ) {
                                myFeedback3 = Icons.star_outlined;
                                myFeedbackColor3 = Colors.yellow;
                              }
                              else if (sliderValue < 3.0 ){
                                myFeedback3 = Icons.star;
                                myFeedbackColor3 = Colors.grey;

                              }
                              if (sliderValue == 4.0 ) {
                                myFeedback4 = Icons.star_outlined;
                                myFeedbackColor4 = Colors.yellow;
                              }
                              else if (sliderValue < 4.0 ){
                                myFeedback4 = Icons.star;
                                myFeedbackColor4 = Colors.grey;

                              }
                              if (sliderValue == 5.0 ) {
                                myFeedback5 = Icons.star_outlined;
                                myFeedbackColor5 = Colors.yellow;
                              }
                              else if (sliderValue < 5.0 ){
                                myFeedback5 = Icons.star;
                                myFeedbackColor5 = Colors.grey;

                              }*/

                                });
                              },
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Row(children: const [
                                          Icon(
                                            Icons.man_outlined,
                                            color: primaryColor,
                                          ),
                                          SizedBox(width: defaultPadding / 2),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text("Professors: ",
                                              style: TextStyle(fontSize: 16,),
                                            ),
                                          ),
                                        ],),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(profSlider.toStringAsFixed(0),
                                      style: TextStyle(fontSize: 16,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(child: Slider(
                              min: 0.0,
                              max: 100.0,
                              divisions: 100,
                              value: profSlider,
                              activeColor: primaryColor[300],
                              inactiveColor: secondaryColor[300],
                              onChanged: (newValue) {
                                setState(() {
                                  profSlider = newValue;
                                });
                              },
                            ),),
                          ),
                          const SizedBox(height: defaultPadding),
                        ],),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Container(
                    child: Align(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding),
                        child: Material(
                          color: Colors.white,
                          elevation: 14.0,
                          borderRadius: BorderRadius.circular(24.0),
                          shadowColor: primaryColor[300],
                          child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding),
                              child: TextFormField(
                                validator: RequiredValidator(errorText: 'Review text is required'),
                                controller: reviewController,
                                autocorrect: false,
                                enableSuggestions: false,
                                autofocus: false,
                                maxLines: null,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(hintText: "Text",
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
                                  ),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(defaultPadding / 4, defaultPadding / 4,
                                  defaultPadding / 4, defaultPadding),
                              child: Container(child: Align(
                                alignment: Alignment.bottomCenter,
                                child: FloatingActionButton(
                                  heroTag: null,
                                  elevation: 10,
                                  backgroundColor: primaryColor[300],
                                  splashColor: secondaryColor[300],
                                  onPressed: () async {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: primaryColor,
                                          content: Text(
                                            'Review Posted',
                                            //textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                      await SubjectClass().postReview(
                                          reviewController.text,
                                          difficultySlider.toStringAsFixed(0),
                                          usabilitySlider.toStringAsFixed(0),
                                          profSlider.toStringAsFixed(0),
                                          widget.subj_id);

                                      revertState(context, widget.subj_id.toString());

                                      //Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
                                    }
                                  },
                                  child: const Icon(
                                    Icons.check_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}