import 'package:form_field_validator/form_field_validator.dart';
import 'package:mtaa_frontend/Screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:mtaa_frontend/Screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../Models/auth.dart';
import '../UI/loading_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen();

  @override
  SignInScreenState createState() => SignInScreenState();
}


class SignInScreenState extends State<SignInScreen> {
  bool _isloading = false;
  // It's time to validat the text field
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  sendLogin() async {
    setState(() {
      _isloading = true;
    });
    //await Future.delayed(const Duration(seconds: 2));  //comment this
    //fetch data here
    //TODO add method to post login
    var response = Provider.of<Auth>(context, listen: false).login(emailController.text, passwordController.text);
    setState(() {
      _isloading = false;
    });
  }

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

  Widget emailInput(TextEditingController userInput, String hintTitle, TextInputType keyboardType,
      bool obscure, IconData icon_) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          keyboardType: keyboardType,
          obscureText: obscure,
          decoration: InputDecoration(hintText: hintTitle,
            hintStyle: const TextStyle(color: backgroundText),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(top: 0), // add padding to adjust icon
              child: Icon(Icons.email_outlined),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: secondaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(25.0),
            ),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // But still same problem, let's fixed it
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
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
                      const SizedBox(height: defaultPadding * 12),
                      Align(
                          child: Image.asset('assets/Images/puzzle.png',
                            height: 80.0,
                            fit: BoxFit.cover,
                          )
                      ),
                      const SizedBox(height: defaultPadding * 4),
                      //const SizedBox(height:defaultPadding * 4),
                      // TextFieldName(text: "Email"),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Email is required"),
                              EmailValidator(
                                  errorText:
                                  "Please enter a valid email address"),
                            ]),
                            onEditingComplete: () => FocusScope.of(context).nextFocus(),
                            controller: emailController,
                            autocorrect: false,
                            enableSuggestions: false,
                            autofocus: false,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            decoration: InputDecoration(hintText: "Email",
                              hintStyle: const TextStyle(color: backgroundText, fontFamily: 'RobotoMono'),
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
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: primaryColor),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //const SizedBox(height: defaultPadding),
                      // TextFieldName(text: "Password"),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
                          child: TextFormField(
                            validator: RequiredValidator(errorText: 'Password is required'),
                            controller: passwordController,
                            autocorrect: false,
                            enableSuggestions: false,
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(hintText: "Password",
                              hintStyle: const TextStyle(color: backgroundText, fontFamily: 'Roboto'),
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
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: primaryColor),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //const SizedBox(height: defaultPadding * 2),
                      const SizedBox(height: defaultPadding),
                      SizedBox(
                        width: 125,
                        child: RaisedButton(
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          color: primaryColor[300],
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              print(emailController);
                              print(passwordController);
                              setState(() {
                                _isloading = true;
                              });
                              var response = await Provider.of<Auth>(context, listen: false).login(emailController.text, passwordController.text);

                              if (response == null) {
                                responseBar("There was en error logging in. Check your connection.", secondaryColor);
                              }
                              else {
                                if (response.statusCode == 200) {
                                  responseBar("Login successful", primaryColor);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
                                }
                                else if (response.statusCode == 403) {
                                  responseBar("Invalid credentials. Check your email and password.", secondaryColor);
                                  //Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
                                }
                                else if (response.statusCode >= 500) {
                                  responseBar("There is an error on server side, sit tight...", secondaryColor);
                                }
                                else {
                                  responseBar("There was en error logging in. Check your connection.", secondaryColor);
                                }
                              }

                              setState(() {
                                _isloading = false;
                              });
                              //Provider.of<Auth>(context, listen: false).login(emailController.text, passwordController.text);
                            }
                          },
                          child: const Text("Login", style: TextStyle(color: Colors.white,
                              fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: defaultPadding / 4),
                      SizedBox(
                        width: 125,
                        child: RaisedButton(
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          color:secondaryColor[300],
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          ),
                          child: const Text("Register", style: TextStyle(color: Colors.white,
                              fontSize: 16)),
                        ),     // width: size.width * 0.35,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          circularLoadingScreen(_isloading),
        ],
      ),
    );
  }
}