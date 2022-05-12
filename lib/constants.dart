import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/components/futureQueue.dart';

const primaryColor = Colors.cyan;
const secondaryColor = Colors.pink;
const tertiaryColor = Colors.purple;
const quaternaryColor = Colors.orange;
const mainTextColor = Colors.black87;
const textColor = Colors.black54;
const backgroundText = Colors.black26;
const backgroundColor = Color(0xFFEAEAEA);

const defaultPadding = 16.0;
var futureQueue = FutureQueue(5);

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor.withOpacity(0.1),
  ),
);

const emailError = 'Enter a valid email address';
const requiredField = "This field is required";

enum ResponseMethods {
  DeleteProfessorReview,
  PostProfessorReview,
  PutProfessorReview,
  DeleteSubjectReview,
  PostSubjectReview,
  PutSubjectReview,
  DeletePic,
  PutMyUserPic
}



