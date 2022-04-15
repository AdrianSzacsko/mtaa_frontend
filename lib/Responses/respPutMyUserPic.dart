
import 'dart:typed_data';

import '../Models/User.dart';
import '../Models/profile.dart';
import '../Screens/profile_page.dart';
import '../UI/responseBar.dart';
import '../constants.dart';
import 'package:flutter/material.dart';

respPutMyUserPic(int user_id, Uint8List newFileBytes, context) async {
  var resp = Profile().putProfilePic(bytes: newFileBytes);
  if (resp == null) {
    responseBar(
        "There was en error putting profile picture.", secondaryColor,
        context);
  }
  else {
    if (resp.statusCode == 200) {
      responseBar("Picture posted", primaryColor, context);
    }
    else if (resp.statusCode == 401 || resp.statusCode == 404) {
      responseBar(resp.data["detail"], secondaryColor, context);
    }
    else if (resp.statusCode >= 500) {
      responseBar(
          "There is an error on server side, sit tight...", secondaryColor,
          context);
    }
    else {
      responseBar(
          "There was en error fetching profile picture.", secondaryColor,
          context);
    }
  }
}