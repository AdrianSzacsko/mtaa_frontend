
import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

import '../../Models/Professor.dart';
import '../../Models/User.dart';
import '../../Models/prof.dart';
import '../../Models/profile.dart';
import '../../UI/responseBar.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';

import '../../key.dart';


respGetSubjectCache(String getProfessor, String getProfessorReviews, APICacheManager cacheData, String professorId) async {

  if (await cacheData.isAPICacheKeyExist(getProfessor) == false){
    return null;
  }
  var cache = await cacheData.getCacheData(getProfessor);
  var cache2 = await cacheData.getCacheData(getProfessorReviews);

  var data = json.decode(cache.syncData);
  var data2 = json.decode(cache2.syncData);

  List<List<String>> allReviews = <List<String>>[];
  try {
    if (data2.containsKey("detail")){
      allReviews = <List<String>>[];
    }
  }
  catch(e){
    allReviews = <List<String>>[];
    data2?.forEach((item) {
      allReviews.add([item["id"].toString(), item["user_id"].toString(),
        item["message"].toString(), item["rating"].toString()]);
    });
  }

  var professor = Professor(
    prof_id: professorId,
    name: data[0]["name"],
    reviews: allReviews,
  );

  return professor;
}


respGetProfessor(String prof_id, context) async {

  var cacheData = APICacheManager();
  String getProfessor = 'prof/' + prof_id.toString();
  String getProfessorReviews = 'prof/' + prof_id.toString() + "/reviews";

  var resp = await ProfessorClass().getProfessor(prof_id);
  if (resp == null) {


    var professor = await respGetSubjectCache(getProfessor, getProfessorReviews, cacheData, prof_id);
    if (professor == null) {
      responseBar("There was en error during execution. Check your connection.",
          secondaryColor, context);
    }
    else{
      return professor;
    }
  }
  else {
    if (resp.statusCode == 200) {
      var resp2 = await ProfessorClass().getProfessorReviews(prof_id);

      if (resp2 == null) {
        responseBar(
            "There was en error fetching professor reviews.", secondaryColor,
            context);
      }
      else {
        if (resp2.statusCode == 200) {

          List<List<String>> allReviews = <List<String>>[];
          resp2.data?.forEach((item) {
            allReviews.add([item["id"].toString(), item["user_id"].toString(),
              item["message"].toString(), item["rating"].toString()]);
          });

          var professor = Professor(
            prof_id: prof_id,
            name: resp.data[0]["name"],
            reviews: allReviews,
          );

          await cacheData.addCacheData(APICacheDBModel(key: getProfessor, syncData: json.encode(resp.data)));
          await cacheData.addCacheData(APICacheDBModel(key: getProfessorReviews, syncData: json.encode(resp2.data)));

          return professor;
        }
        else if (resp2.statusCode == 404) {
          var professor = Professor(
            prof_id: prof_id,
            name: resp.data[0]["name"],
            reviews: <List<String>>[],
          );

          await cacheData.addCacheData(APICacheDBModel(key: getProfessor, syncData: json.encode(resp.data)));
          await cacheData.addCacheData(APICacheDBModel(key: getProfessorReviews, syncData: json.encode(resp2.data)));

          return professor;
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
              "There was en error fetching professor reviews.", secondaryColor,
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