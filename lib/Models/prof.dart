import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:mtaa_frontend/key.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfessorClass with ChangeNotifier {
  Future<dynamic> getProfessor(String prof_id) async {
    Response response;

    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      response = await dio.get(urlKey + 'prof/' + prof_id);
      return response;
    }
    on DioError catch (e) {
      return e.response;
    }

    return null;
  }

  Future<dynamic> getProfessorReviews(String prof_id) async {
    Response response;

    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      response =
      await dio.get(urlKey + 'prof/' + prof_id + "/reviews");
      print(response.data);
      return response;
    }
    on DioError catch (e) {
      return e.response;
    }
  }

  postReview(String message, String rating, String prof_id) async {
    var dio = Dio();
    //dio.options.headers['content-Type'] = 'application/json';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      var response = await dio.post(urlKey + 'prof/', data: {
        'message': message,
        'rating': int.parse(rating),
        'prof_id': int.parse(prof_id)
      });
      return response;
    }
    on DioError catch (e) {
      return e.response;
    }
  }

  modifyReview(String message, String rating, String prof_id) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      Response response = await dio.put(urlKey + 'prof/', data: {
        'message': message,
        'rating': int.parse(rating),
        'prof_id': int.parse(prof_id)
      });
      return response;
    }
    on DioError catch (e) {
      return e.response;
    }
  }

  Future<dynamic?> deleteReview(String user_id, String prof_id) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      Response response = await dio.delete(urlKey + 'prof/delete_review', queryParameters: {
        "uid": user_id,
        "pid": prof_id
      });
      return response;
    }
    on DioError catch (e) {
      return e.response;
    }
  }
}