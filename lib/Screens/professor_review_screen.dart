import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mtaa_frontend/Screens/search_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}