
import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

import '../../Models/User.dart';
import '../../Models/profile.dart';
import '../../UI/responseBar.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';

import '../../key.dart';

respGetMyUserCache(String getProfile, APICacheManager cacheData) async {

  if (!(await cacheData.isAPICacheKeyExist(getProfile))) {
    return null;
  }
  var cache = await cacheData.getCacheData(getProfile);

  var data = json.decode(cache.syncData);

  var myUser = User(
      user_id: data[0]["id"],
      email: data[0]["email"],
      name: data[0]["name"],
      comments: data[0]["comments"].toString(),
      reg_date: data[0]["reg_date"].toString(),
      study_year: data[0]["study_year"].toString(),
      image: const AssetImage("assets/Images/profile-unknown.png"),
      permission: data[0]["permission"].toString().toLowerCase() ==
          'true' ? true : false
  );
  return myUser;
}


respGetMyUser(int user_id, context) async {
  var cacheData = APICacheManager();
  String getProfile = urlKey + 'profile/' + user_id.toString();


  var resp = await Profile().getProfile(user_id.toString());
  var resp2 = await Profile().getProfilePic(user_id.toString());


  if (resp == null) {
    var myUser = await respGetMyUserCache(getProfile, cacheData);
    if (myUser == null) {
      responseBar("There was en error during execution. Check your connection.",
          secondaryColor, context);
    }
    else{
      return myUser;
    }
  }
  else {
    if (resp.statusCode == 200) {
//responseBar("Registration successful", primaryColor);

      if (resp2 == null) {
        responseBar(
            "There was en error fetching profile picture.", secondaryColor,
            context);
      }
      else {
        if (resp2[0].statusCode == 200 || resp2[0].statusCode == 404) {
          var myUser = User(
              user_id: resp.data[0]["id"],
              email: resp.data[0]["email"],
              name: resp.data[0]["name"],
              comments: resp.data[0]["comments"].toString(),
              reg_date: resp.data[0]["reg_date"].toString(),
              study_year: resp.data[0]["study_year"].toString(),
              image: resp2[1] ??
                  const AssetImage("assets/Images/profile-unknown.png"),
              permission: resp.data[0]["permission"].toString().toLowerCase() ==
                  'true' ? true : false
          );
          await cacheData.addCacheData(APICacheDBModel(key: getProfile, syncData: json.encode(resp.data)));
          return myUser;
        }
        else if (resp2[0].statusCode == 401) {
          responseBar(resp2[0].data["detail"], secondaryColor, context);
        }
        else if (resp2[0].statusCode >= 500) {
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
          "There was en error during execution.", secondaryColor, context);
    }
  }
  return null;
}