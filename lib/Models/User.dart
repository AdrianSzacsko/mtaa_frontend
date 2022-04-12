//import 'dart:ui';
import 'dart:io';

import 'package:flutter/widgets.dart';

class User {
  final String email;
  final String name;
  final String comments;
  final String reg_date;
  final String study_year;
  final ImageProvider image;

  const User({
    required this.email,
    required this.name,
    required this.comments,
    required this.reg_date,
    required this.study_year,
    required this.image,
  });
}