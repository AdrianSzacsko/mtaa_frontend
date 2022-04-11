import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mtaa_frontend/UI/appbar.dart';

import '../Models/subj.dart';
import '../constants.dart';


class SubjectReviewScreen extends StatefulWidget {
  const SubjectReviewScreen({Key? key}) : super(key: key);

  @override
  _SubjectReviewScreenState createState() => _SubjectReviewScreenState();
}

class _SubjectReviewScreenState extends State<SubjectReviewScreen> {
  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final passwordController = TextEditingController();
  final studyYearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // But still same problem, let's fixed it
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              "assets/Images/top-left-2.jpg",
              width: MediaQuery.of(context).size.height * 0.2,
              // height: MediaQuery.of(context).size.height,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              "assets/Images/bot-right-2.jpg",
              width: MediaQuery.of(context).size.height * 0.2,
              // height: MediaQuery.of(context).size.height,
            ),
          ),
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [  // TODO: HERE GOES LOGO INSTEAD OF TEXT
                    Align(
                        child: Image.asset('assets/Images/puzzle.png',
                          height: 80.0,
                          fit: BoxFit.cover,
                        )
                    ),
                    /*
                    Text(
                      "Create Account",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),*/
                    const SizedBox(height: defaultPadding * 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TextFieldName(text: "Email"),
                        // const SizedBox(height:defaultPadding * 2),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: defaultPadding),
                            child: TextFormField(
                              controller: emailController,
                              autocorrect: false,
                              enableSuggestions: false,
                              autofocus: false,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              decoration: InputDecoration(hintText: "Email",
                                hintStyle: const TextStyle(color: backgroundText),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                                  child: Icon(Icons.email_outlined),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),),
                              validator: EmailValidator(errorText: "Invalid email"),
                              // Let's save our email
                            ),
                          ),
                        ),
                        //const SizedBox(height: defaultPadding),

                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: defaultPadding),
                            child: TextFormField(
                              controller: firstnameController,
                              autocorrect: false,
                              enableSuggestions: false,
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              decoration: InputDecoration(hintText: "Joseph",
                                hintStyle: const TextStyle(color: backgroundText),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                                  child: Icon(Icons.account_circle_outlined),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),),
                              validator: RequiredValidator(errorText: "First name is required"),
                            ),
                          ),
                        ),

                        //const SizedBox(height: defaultPadding),

                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: defaultPadding),
                            child: TextFormField(
                              controller: lastnameController,
                              autocorrect: false,
                              enableSuggestions: false,
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              decoration: InputDecoration(hintText: "Carrot",
                                hintStyle: const TextStyle(color: backgroundText),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                                  child: Icon(Icons.account_circle_outlined),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),),
                              validator: RequiredValidator(errorText: "Last name is required"),
                            ),
                          ),
                        ),

                        //const SizedBox(height: defaultPadding),

                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: defaultPadding),
                            child: TextFormField(
                              controller: passwordController,
                              autocorrect: false,
                              enableSuggestions: false,
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              // We want to hide our password
                              obscureText: true,
                              decoration: InputDecoration(hintText: "Password",
                                hintStyle: const TextStyle(color: backgroundText),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                                  child: Icon(Icons.lock_outlined),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),),
                              validator: RequiredValidator(errorText: "Password is required"),
                            ),
                          ),
                        ),

                        // const SizedBox(height: defaultPadding),

                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: defaultPadding),
                            child: TextFormField(
                              controller: studyYearController,
                              autocorrect: false,
                              enableSuggestions: false,
                              autofocus: false,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(hintText: "1",
                                hintStyle: const TextStyle(color: backgroundText),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                                  child: Icon(Icons.school_outlined),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),),
                              validator: RequiredValidator(errorText: "Study year is required"),
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    SizedBox(
                      width: 125,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        color:primaryColor[300],
                        onPressed: () {
                          print(emailController);
                          print(firstnameController);
                          print(lastnameController);
                          print(passwordController);
                          print(studyYearController);
                          /*
                          Provider.of<Auth>(context, listen: false).register(emailController.text,
                            firstnameController.text,
                            lastnameController.text,
                            int.parse(studyYearController.text),
                            passwordController.text,
                          );
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SignUpScreen()));*/
                        },
                        child: const Text("Register", style: TextStyle(color: textColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarFeedback extends StatefulWidget {
  @override
  _StarFeedbackState createState() => _StarFeedbackState();
}

class _StarFeedbackState extends State<StarFeedback> {
  var myFeedbackText = "COULD BE BETTER";
  var difficultySlider = 0.0;
  var usabilitySlider = 0.0;
  var profSlider = 0.0;
  final reviewController = TextEditingController();
  IconData myFeedback1= Icons.star, myFeedback2= Icons.star,myFeedback3= Icons.star,
      myFeedback4= Icons.star,myFeedback5 = Icons.star;
  Color myFeedbackColor1 = Colors.grey,myFeedbackColor2 = Colors.grey,myFeedbackColor3 = Colors.grey,
      myFeedbackColor4 = Colors.grey,myFeedbackColor5 = Colors.grey;

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
                      child: Text("Subject Review",
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
                                    await SubjectClass().postReview(
                                      reviewController.text,
                                        difficultySlider.toString(),
                                        usabilitySlider.toString(),
                                        profSlider.toString(),
                                        "5");
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