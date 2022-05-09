
import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

import '../../Models/Professor.dart';
import '../../Models/Subject.dart';
import '../../Models/User.dart';
import '../../Models/prof.dart';
import '../../Models/profile.dart';
import '../../Models/subj.dart';
import '../../UI/responseBar.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';

import '../../key.dart';


respGetSubjectCache(String getSubject, String getSubjectReviews, APICacheManager cacheData, String subjectId) async {

  if (await cacheData.isAPICacheKeyExist(getSubject) == false){
    return null;
  }
  var cache = await cacheData.getCacheData(getSubject);
  var cache2 = await cacheData.getCacheData(getSubjectReviews);

  var data = json.decode(cache.syncData);
  var data2 = json.decode(cache2.syncData);
  print(data2);

  List<String> allProfessors = <String>[];
  data?.forEach((item) {
    allProfessors.add(item["teachers"]);
  });

  List<List<String>> allReviews = <List<String>>[];
  try {
    if (data2.containsKey("detail")){
      allReviews = <List<String>>[];
    }
  }
  catch(e){
    allReviews = <List<String>>[];
    data2?.forEach((item) {
      allReviews.add([item["id"].toString(),
        item["user_id"].toString(),
        item["message"].toString(), item["difficulty"].toString(),
        item["usability"].toString(), item["prof_avg"].toString()]);
    });
  }

  var subject = Subject(
    subj_id: subjectId,
    name: data[0]["name"],
    professors: allProfessors,
    reviews: allReviews,
  );

  return subject;
}


respGetSubject(String subj_id, context) async {
  var cacheData = APICacheManager();
  String getSubject = 'subj/' + subj_id.toString();
  String getSubjectReviews = 'subj/' + subj_id.toString() + "/reviews";

  var resp = await SubjectClass().getSubject(subj_id);
  if (resp == null) {


    var subject = await respGetSubjectCache(getSubject, getSubjectReviews, cacheData, subj_id);
    if (subject == null) {
      responseBar("There was en error during execution. Check your connection.",
          secondaryColor, context);
    }
    else {
      return subject;
    }
  }
  else {
    if (resp.statusCode == 200) {
      var resp2 = await SubjectClass().getSubjectReviews(subj_id);

      if (resp2 == null) {
        responseBar(
            "There was en error fetching subject reviews.", secondaryColor,
            context);
      }
      else {
        if (resp2.statusCode == 200) {
          List<String> allProfessors = <String>[];
          resp.data?.forEach((item) {
            allProfessors.add(item["teachers"]);
          });

          List<List<String>> allReviews = <List<String>>[];
          resp2.data?.forEach((item) {
            allReviews.add([item["id"].toString(),
              item["user_id"].toString(),
              item["message"].toString(), item["difficulty"].toString(),
              item["usability"].toString(), item["prof_avg"].toString()]);
          });

          var subject = Subject(
            subj_id: subj_id,
            name: resp.data[0]["name"],
            professors: allProfessors,
            reviews: allReviews,
          );
          await cacheData.addCacheData(APICacheDBModel(key: getSubject, syncData: json.encode(resp.data)));
          await cacheData.addCacheData(APICacheDBModel(key: getSubjectReviews, syncData: json.encode(resp2.data)));
          return subject;
        }
        else if (resp2.statusCode == 404) {
          var subject = Subject(
            subj_id: subj_id,
            name: resp.data[0]["name"],
            professors: <String>[],
            reviews: <List<String>>[],
          );
          await cacheData.addCacheData(APICacheDBModel(key: getSubject, syncData: json.encode(resp.data)));
          await cacheData.addCacheData(APICacheDBModel(key: getSubjectReviews, syncData: json.encode(resp2.data)));
          return subject;
        }
        else if (resp2.statusCode == 401) {
          responseBar(resp2.data["detail"], secondaryColor, context);
        }
        else if (resp2.statusCode >= 500) {
          responseBar(
              "There is an error on server side, sit tight...", secondaryColor,
              context);
        }
        else {
          responseBar(
              "There was en error fetching subject reviews.", secondaryColor,
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