import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mtaa_frontend/Screens/professor_screen.dart';
import 'package:mtaa_frontend/Screens/search_screen.dart';
import 'package:mtaa_frontend/Screens/subject_screen.dart';
import 'package:mtaa_frontend/UI/appbar.dart';

import '../Models/Professor.dart';
import '../Models/Subject.dart';
import '../Models/prof.dart';
import '../Models/subj.dart';
import '../Responses/Professor/respGetProfessor.dart';
import '../Responses/Professor/respPutProfessorReview.dart';
import '../constants.dart';


class EditProfessorReviewScreen extends StatefulWidget {
  final String prof_id;
  final String message;
  final String rating;

  EditProfessorReviewScreen({required this.prof_id, required this.message,
    required this.rating});

  @override
  _EditProfessorReviewScreenState createState() => _EditProfessorReviewScreenState();
}

class _EditProfessorReviewScreenState extends State<EditProfessorReviewScreen> {
  //var myFeedbackText = "COULD BE BETTER";
  var myFeedbackText = "COULD BE BETTER";
  late var ratingSlider = double.parse(widget.rating);
  late var reviewController = TextEditingController(text: widget.message);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void revertState(BuildContext context, String prof_id) async {
    var professor = await respGetProfessor(prof_id, context);

    if (professor != null) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => SearchScreen()));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfessorScreen(),
          settings: RouteSettings(
            arguments: professor,
          ),
        ),
      );
    }
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
                        ],),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Align(
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

                                    bool resp = await respPutProfessorReview(
                                        reviewController.text,
                                        ratingSlider.toStringAsFixed(0),
                                        widget.prof_id,
                                        context);
                                    if (resp) {
                                      revertState(context, widget.prof_id.toString());
                                    }
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}