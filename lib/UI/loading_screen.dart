import 'package:flutter/material.dart';

import '../constants.dart';

Widget linearLoadingScreen(bool _isloading) {
  return _isloading ? Container(
    alignment: Alignment.topCenter,
    child: const LinearProgressIndicator(
      color: secondaryColor,
      backgroundColor: primaryColor,
    ),
  ): const SizedBox.shrink();
}

Widget circularLoadingScreen(bool _isloading) {
  return _isloading ? Container(
    alignment: Alignment.center,
    child: const CircularProgressIndicator(
      color: secondaryColor,
      backgroundColor: primaryColor,
    ),
  ): const SizedBox.shrink();
}