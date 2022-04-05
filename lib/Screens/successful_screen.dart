/*
* this dart file made by: https://github.com/tommybarral/Sign-in-up
*/

import 'package:flutter/material.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Congratulation', style: TextStyle(fontSize: 24),),
      ),
    );
  }
}