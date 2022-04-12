import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mtaa_frontend/Screens/search_screen.dart';
import 'package:mtaa_frontend/Screens/subject_screen.dart';
import 'package:mtaa_frontend/UI/appbar.dart';

import '../Models/Subject.dart';
import '../Models/subj.dart';
import '../constants.dart';


class EditSubjectReviewScreen extends StatefulWidget {
  final String subj_id;
  final String message;
  final String difficulty;
  final String usability;
  final String prof_avg;

  EditSubjectReviewScreen({required this.subj_id, required this.message,
    required this.difficulty, required this.usability, required this.prof_avg});

  @override
  _EditSubjectReviewScreenState createState() => _EditSubjectReviewScreenState();
}

class _EditSubjectReviewScreenState extends State<EditSubjectReviewScreen> {
  //var myFeedbackText = "COULD BE BETTER";
  var myFeedbackText = "COULD BE BETTER";
  late var difficultySlider = double.parse(widget.difficulty);
  late var usabilitySlider = double.parse(widget.usability);
  late var profSlider = double.parse(widget.prof_avg);
  late var reviewController = TextEditingController(text: widget.message);

  IconData myFeedback1= Icons.star, myFeedback2= Icons.star,myFeedback3= Icons.star,
      myFeedback4= Icons.star,myFeedback5 = Icons.star;
  Color myFeedbackColor1 = Colors.grey,myFeedbackColor2 = Colors.grey,myFeedbackColor3 = Colors.grey,
      myFeedbackColor4 = Colors.grey,myFeedbackColor5 = Colors.grey;

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              //color: backgroundColor,
              child: Column(
                children: <Widget>[
                  const SizedBox(height:defaultPadding),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Text("Edit Review",
                        style: TextStyle(color: Colors.black, fontSize: 22.0,fontWeight:FontWeight.bold),),
                    ),
                  ),
                  const SizedBox(height:defaultPadding / 2),
                  Container(
                    child: Align(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding),
                        child: Material(
                          color: Colors.white,
                          elevation: 14.0,
                          borderRadius: BorderRadius.circular(24.0),
                          shadowColor: primaryColor[300],
                          child: Container(
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
                                const SizedBox(height: defaultPadding),
                              ],)
                          ),
                        ),
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
                              child: Container(
                                child:
                                TextFormField(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(defaultPadding / 4),
                              child: Container(child: Align(
                                alignment: Alignment.bottomCenter,
                                child: RaisedButton(
                                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                  color: primaryColor[300],
                                  child: const Text('Submit',
                                    style: TextStyle(color: Color(0xffffffff)),
                                  ),
                                  onPressed: () async {
                                    await SubjectClass().modifyReview(
                                        reviewController.text,
                                        difficultySlider.toStringAsFixed(0),
                                        usabilitySlider.toStringAsFixed(0),
                                        profSlider.toStringAsFixed(0),
                                        widget.subj_id);

                                    //Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
                                    revertState(context, widget.subj_id.toString());
                                  },
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

  Widget mySlider() {
    return Container(
      child: Row(children: [
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
          child: Container(
            child: Slider(
              min: 0.0,
              max: 100.0,
              divisions: 100,
              value: difficultySlider,
              activeColor: primaryColor[300],
              inactiveColor: secondaryColor[300],
              onChanged: (newValue) {
                setState(() {
                  difficultySlider = newValue;

                }
                );
              },
            ),),
        ),
      ],),
    );
  }


  Widget _myAppBar() {
    return Container(
      height: 70.0,
      width: MediaQuery
          .of(context)
          .size
          .width,

      decoration: BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            const Color(0xff662d8c),
            const Color(0xffed1e79),
          ],
          begin: Alignment.centerRight,
          end: new Alignment(-1.0, -1.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child:Container(child:IconButton(
                      icon: Icon(Icons.arrow_left,color: Colors.white,), onPressed: () {
                    //
                  }),),),
                Expanded(
                  flex: 5,
                  child:Container(child:Text('Rate', style:
                  TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0
                  ),),),),
                Expanded(
                  flex: 1,
                  child:Container(child:IconButton(
                      icon: Icon(Icons.star,color: Colors.white,), onPressed: () {
                    //
                  }),),),
              ],)
        ),
      ),
    );
  }
}