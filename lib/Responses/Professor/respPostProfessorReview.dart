import '../../Models/prof.dart';
import '../../UI/responseBar.dart';
import '../../constants.dart';

respPostProfessorReview(String text, String rating, String prof_id, context) async {
  var resp = await ProfessorClass().postReview(
      text,
      rating,
      prof_id
  );
  if (resp == null) {
    futureQueue.push({"method": ResponseMethods.PostProfessorReview, "params":[text, rating, prof_id]});
    responseBar(
        "You are not connected, review will be posted as soon as you reconnect.", secondaryColor,
        context);
    return true;
  }
  else {
    if (resp.statusCode == 201) {
      responseBar("Review posted", primaryColor, context);
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
    else if (resp.statusCode == 400) {
      responseBar(
          "Review already exists. Try modifying your existing one.", secondaryColor,
          context);
      return true;
    }
    else {
      responseBar(
          "There was en error posting the review.", secondaryColor,
          context);
      return false;
    }
  }
}