
import '../../Models/profile.dart';
import '../../UI/responseBar.dart';
import '../../constants.dart';

respDeletePic(context) async {
  var resp = await Profile().deleteProfilePic();
  if (resp == null) {
    futureQueue.push({"method": ResponseMethods.DeletePic, "params":[]});
    responseBar(
        "You are not connected, picture will be deleted as soon as you reconnect.", secondaryColor,
        context);
  }
  else if (resp.statusCode == 200) {
    responseBar("Profile picture deleted.", primaryColor, context);
  }
}