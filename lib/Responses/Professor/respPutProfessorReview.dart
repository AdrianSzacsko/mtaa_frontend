import '../../Models/prof.dart';
import '../../UI/responseBar.dart';
import '../../constants.dart';

respPutProfessorReview(String text, String rating, String prof_id, context) async {
  var resp = await ProfessorClass().modifyReview(
      text,
      rating,
      prof_id
  );
  if (resp == null) {
    futureQueue.push({"method": ResponseMethods.PutProfessorReview, "params":[text, rating, prof_id]});
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