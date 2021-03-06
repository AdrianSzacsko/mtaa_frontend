import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../key.dart';


class SubjectClass with ChangeNotifier {
  Future<dynamic> getSubject(String subj_id) async {
    Response response;

    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      response = await dio.get(urlKey + 'subj/' + subj_id);
      return response;
    }
    on DioError catch (e) {
      return e.response;
    }

    return null;
  }

  Future<dynamic> getSubjectReviews(String subj_id) async {
    Response response;

    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      response = await dio.get(urlKey + 'subj/' + subj_id + "/reviews");
      return response;
    }
    on DioError catch (e) {
      return e.response;
    }
  }

  postReview(String message, String difficulty, String usability,
      String prof_avg, String subj_id) async {
    Response response;

    var dio = Dio();
    //dio.options.headers['content-Type'] = 'application/json';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      var response = await dio.post(urlKey + 'subj/', data: {
        'message': message,
        'difficulty': int.parse(difficulty),
        'usability': int.parse(usability),
        'prof_avg': int.parse(prof_avg),
        'subj_id': int.parse(subj_id)
      });
      print(response.data);
      return response;
    }
    on DioError catch (e) {
      return e.response;
    }
  }

  modifyReview(String message, String difficulty,
      String usability, String prof_avg, String subj_id) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      Response response = await dio.put(urlKey + 'subj/', data: {
        'message': message,
        'difficulty': int.parse(difficulty),
        'usability': int.parse(usability),
        'prof_avg': int.parse(prof_avg),
        'subj_id': int.parse(subj_id)
      });
      return response;
    }
    on DioError catch (e) {
      return e.response;
    }
  }

  Future deleteReview(String user_id, String subj_id) async {
    var response;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      response = await dio.delete(urlKey + 'subj/delete_review', queryParameters: {
        "uid": user_id,
        "sid": subj_id
      });
      return response;
    }
    on DioError catch (e) {
      return e.response;
    }
  }
}