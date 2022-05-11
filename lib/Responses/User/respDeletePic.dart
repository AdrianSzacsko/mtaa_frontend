
import '../../Models/profile.dart';
import '../../UI/responseBar.dart';
import '../../constants.dart';

respDeletePic(context) async {
  var resp = await Profile().deleteProfilePic();
  if (resp == null) {
    futureQueue.push({"method": ResponseMethods.DeletePic, "params":[]});
  }
  else if (resp.statusCode == 200) {
    responseBar("Profile picture deleted.", primaryColor, context);
  }
}