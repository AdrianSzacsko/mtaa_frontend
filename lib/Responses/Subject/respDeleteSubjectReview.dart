import '../../Models/subj.dart';
import '../../UI/responseBar.dart';
import '../../constants.dart';

respDeleteSubjectReview(String user_id, String subj_id, context) async {
  var resp = await SubjectClass().deleteReview(
      user_id,
      subj_id
  );
  if (resp == null) {
    futureQueue.push({"method": ResponseMethods.DeleteSubjectReview, "params":[user_id, subj_id]});
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