import 'package:mtaa_frontend/Screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

import '../Models/auth.dart';
import '../constants.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'components/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen();

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  // It's time to validat the text field
  bool _isloading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final passwordController = TextEditingController();
  final studyYearController = TextEditingController();

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
          Padding (
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "Required"),
                                    EmailValidator(
                                        errorText:
                                        "Please enter a valid email address"),
                                  ]),
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
                                  validator: RequiredValidator(errorText: "First name is required"),
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
                                  validator: RequiredValidator(errorText: "Last name is required"),
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
                                  validator: RequiredValidator(errorText: "Password is required"),
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
                                  validator: RequiredValidator(errorText: "Study year is required"),
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
                                ),
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                        SizedBox(
                          width: 125,
                          child: RaisedButton(
                            elevation: 10,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            color: primaryColor[300],
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                setState(() {
                                  _isloading = true;
                                });

                                var response = await Provider.of<Auth>(context, listen: false).register(emailController.text,
                                  firstnameController.text,
                                  lastnameController.text,
                                  int.parse(studyYearController.text),
                                  passwordController.text,
                                );

                                if (response == null) {
                                  responseBar("There was en error logging in. Check your connection", secondaryColor);
                                }
                                else {
                                  if (response.statusCode == 201) {
                                    responseBar("Registration successful", primaryColor);
                                    Navigator.of(context).pop();
                                  }
                                  else if (response.statusCode == 403) {
                                    responseBar("Invalid credentials. Check your email and password", secondaryColor);
                                  }
                                  else if (response.statusCode >= 500) {
                                    responseBar("There is an error on server side, sit tight...", secondaryColor);
                                  }
                                  else {
                                    responseBar("There was en error logging in. Check your connection", secondaryColor);
                                  }
                                }

                                setState(() {
                                  _isloading = false;
                                });
                              }
                            },
                            child: const Text("Register", style: TextStyle(color: Colors.white,
                                fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}