import 'package:mtaa_frontend/Screens/register_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  // It's time to validat the text field
  final _formKey = GlobalKey<FormState>();

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
            // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: defaultPadding * 7.5),
                    Align(
                        child: Image.asset('assets/Images/puzzle.png',
                          height: 80.0,
                          fit: BoxFit.cover,
                        )
                    ),/*
                    Row(
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          ),
                          child: const Text(
                            "Sign Up!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),*/
                    const SizedBox(height: defaultPadding * 2),
                    SignInForm(formKey: _formKey),
                    const SizedBox(height: defaultPadding),
                    SizedBox(
                      width: 125,
                      child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      color:primaryColor[300],
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Sign up form is done
                            // It saved our inputs
                            _formKey.currentState!.save();
                            //  Sign in also done
                          }
                        },
                        child: const Text("Login", style: TextStyle(color: textColor)),
                      ),
                    ),
                    SizedBox(
                      width: 125,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        color:secondaryColor[300],
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        ),
                        child: const Text("Register", style: TextStyle(color: textColor)),
                      ),     // width: size.width * 0.35,
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