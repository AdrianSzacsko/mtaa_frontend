import '../../Models/prof.dart';
import '../../UI/responseBar.dart';
import '../../constants.dart';

respDeleteProfessorReview(String user_id, String prof_id, context) async {
  var resp = await ProfessorClass().deleteReview(
      user_id,
      prof_id
  );
  print(resp);
  if (resp == null) {
    responseBar(
        "There was en error deleting the review.", secondaryColor,
        context);
    return false;
  }
  else {
    if (resp.statusCode == 200) {
      responseBar("Review deleted", primaryColor, context);
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
          "There was en error deleting the review.", secondaryColor,
          context);
      return false;
    }
  }
}