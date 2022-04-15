import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/User.dart';
import '../Models/profile.dart';
import '../Responses/User/respGetMyUser.dart';

getUsernameAndPerm(context) async {
  final prefs = await SharedPreferences.getInstance();
  final user_id = prefs.getInt('user_id') ?? 0;

  var myUser = await respGetMyUser(user_id, context);

  if (myUser != null) {
    String name = myUser.name.toString();
    String perm = myUser.permission.toString().toLowerCase() == 'true' ?
    ' [Admin]' : '';
    return name + perm;
  }
  return '';
}