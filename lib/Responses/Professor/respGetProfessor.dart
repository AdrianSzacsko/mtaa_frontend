
import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';

import '../../Models/Professor.dart';
import '../../Models/User.dart';
import '../../Models/prof.dart';
import '../../Models/profile.dart';
import '../../UI/responseBar.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';


respGetProfessor(String prof_id, context) async {
  var resp = await ProfessorClass().getProfessor(prof_id);
  if (resp == null) {
    responseBar("There was en error during execution. Check your connection.",
        secondaryColor, context);
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
          return professor;
        }
        else if (resp2.statusCode == 404) {
          var professor = Professor(
            prof_id: prof_id,
            name: resp.data[0]["name"],
            reviews: <List<String>>[],
          );
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