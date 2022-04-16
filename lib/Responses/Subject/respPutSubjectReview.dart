import 'package:mtaa_frontend/Models/subj.dart';

import '../../UI/responseBar.dart';
import '../../constants.dart';

respPutSubjectReview(String text, String difficulty, String usability,
                  String prof_avg, String subj_id, context) async {

  var resp = await SubjectClass().modifyReview(text, difficulty,
      usability, prof_avg, subj_id);
  if (resp == null) {
    responseBar(
        "There was en error modifying the review.", secondaryColor,
        context);
    return false;
  }
  else {
    if (resp.statusCode == 200) {
      responseBar("Review modified", primaryColor, context);
      return true;
    }
    else if (resp.statusCode == 403) {
      responseBar(resp.data["detail"], secondaryColor, context);
      return false;
    }
    else if (resp.statusCode == 401 || resp.statusCode == 404) {
      //responseBar(resp.data["detail"], secondaryColor, context);
      return true;
    }
    else if (resp.statusCode >= 500) {
      responseBar(
          "There is an error on server side, sit tight...", secondaryColor,
          context);
      return false;
    }
    else {
      responseBar(
          "There was en error modifying the review.", secondaryColor,
          context);
      return false;
    }
  }
}