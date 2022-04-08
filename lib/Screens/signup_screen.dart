/*
* this dart file made by: https://github.com/tommybarral/Sign-in-up
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/auth.dart';
import 'successful_screen.dart';
import 'dart:convert';

class SignupScreen extends StatelessWidget {

  static const routeName = '/signup-screen';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final study_yearController = TextEditingController();

  Widget signUpWith(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(onPressed: () {}, child: Text('Sign in')),
        ],
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color: Colors.blueGrey.shade200, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: TextStyle(fontSize: 18, color: Colors.white70, fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/Images/light-1834289.jpg',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 600,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 45),
                    userInput(emailController, 'Email', TextInputType.emailAddress),
                    userInput(firstnameController, 'First name', TextInputType.text),
                    userInput(lastnameController, 'Last name', TextInputType.text),
                    userInput(passwordController, 'Password', TextInputType.visiblePassword),
                    userInput(study_yearController, 'Study year', TextInputType.number),
                    Container(
                      height: 55,
                      // for an exact replicate, remove the padding.
                      // pour une réplique exact, enlever le padding.
                      padding: const EdgeInsets.only(top: 5, left: 70, right: 70),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        color: Colors.indigo.shade800,
                        onPressed: () {
                          print(emailController);
                          print(passwordController);
                          print(firstnameController);
                          print(lastnameController);
                          print(study_yearController);
                          Provider.of<Auth>(context, listen: false).signup(emailController.text, firstnameController.text, lastnameController.text, int.parse(study_yearController.text),passwordController.text);
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SuccessfulScreen()));
                        },
                        child: Text('Sign up', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          /*signUpWith(Icons.add),
                          signUpWith(Icons.book_online),*/
                        ],
                      ),
                    ),
                    const Divider(thickness: 0, color: Colors.white),
                    /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Text('Don\'t have an account yet ? ', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                    TextButton(
                    onPressed: () {},
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  ],
                ),
                  */
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}