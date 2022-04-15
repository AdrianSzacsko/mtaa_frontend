import 'package:dio/dio.dart';
import 'package:mtaa_frontend/UI/responseBar.dart';

import '../Models/profile.dart';
import '../constants.dart';

respDeleteMyUser(context) async {
  Response response = await Profile().deleteProfile();
  if (response.statusCode == 200){
    responseBar("Account Deleted", primaryColor[300], context);
    return true;
  }
  else if (response.statusCode == 404 || response.statusCode == 401){
    responseBar(response.data["detail"], secondaryColor[300], context);
    return true;
  }
  else {
    responseBar(
        "There was en error during execution.", secondaryColor, context);
    return false;
  }
}