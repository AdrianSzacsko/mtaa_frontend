import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mtaa_frontend/Screens/search_screen.dart';
import 'package:mtaa_frontend/Models/prof.dart';
import 'package:mtaa_frontend/UI/appbar.dart';

import '../Models/subj.dart';
import '../constants.dart';


class ProfessorReviewScreen extends StatefulWidget {
  final String prof_id;
  String? message = "";
  String? rating = "";

  ProfessorReviewScreen({required this.prof_id, this.message,
    this.rating});

  @override
  _ProfessorReviewScreenState createState() => _ProfessorReviewScreenState();
}

class _ProfessorReviewScreenState extends State<ProfessorReviewScreen> {
  late var ratingSlider = 0.0;
  late var reviewController = TextEditingController();

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
                      child: Text("Professor Review",
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
                                                  Icons.star_outlined,
                                                  color: primaryColor,
                                                ),
                                                SizedBox(width: defaultPadding / 2),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text("Rating: ",
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
                                          child: Text(ratingSlider.toStringAsFixed(0),
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
                                    value: ratingSlider,
                                    activeColor: primaryColor[300],
                                    inactiveColor: secondaryColor[300],
                                    onChanged: (newValue) {
                                      setState(() {
                                        ratingSlider = newValue;
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
                                TextField(
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
                                    await ProfessorClass().postReview(
                                        reviewController.text,
                                        ratingSlider.toStringAsFixed(0),
                                        widget.prof_id);

                                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
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
}