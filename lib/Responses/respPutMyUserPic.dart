import 'dart:typed_data';
import '../Models/profile.dart';
import '../UI/responseBar.dart';
import '../constants.dart';


respPutMyUserPic(Uint8List newFileBytes, context) async {
  var resp = await Profile().putProfilePic(bytes: newFileBytes);
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