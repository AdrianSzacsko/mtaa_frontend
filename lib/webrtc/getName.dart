import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/User.dart';
import '../Models/profile.dart';

getUsernameAndPerm() async {
  final prefs = await SharedPreferences.getInstance();
  final user_id = prefs.getInt('user_id') ?? '';

  var resp = await Profile().getProfile(user_id.toString());
  String name = resp[0]["name"].toString();
  String perm = resp[0]["permission"].toString().toLowerCase() == 'true' ?
  ' [Admin]' : '';
  return name + perm;
}