import 'package:mtaa_frontend/Screens/sign_in_screen.dart';

import '../constants.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'components/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  // It's time to validat the text field
  final _formKey = GlobalKey<FormState>();

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
                    SignUpForm(formKey: _formKey),
                    const SizedBox(height: defaultPadding * 2),
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