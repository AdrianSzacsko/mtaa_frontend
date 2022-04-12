import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
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
      response = await dio.get('http://10.0.2.2:8000/prof/' + prof_id);
      print(response.data);
      return response.data;
    }
    catch (e) {
      print(e);
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
      await dio.get('http://10.0.2.2:8000/prof/' + prof_id + "/reviews");
      print(response.data);
      return response.data;
    }
    catch (e) {
      print(e);
    }
  }

  postReview(String message, String rating, String prof_id) async {
    var dio = Dio();
    //dio.options.headers['content-Type'] = 'application/json';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      var response = await dio.post('http://10.0.2.2:8000/prof/', data: {
        'message': message,
        'rating': int.parse(rating),
        'prof_id': int.parse(prof_id)
      });
      print("");
      print("Review added.");
      print("");
      print(response.data);
      return response.data;
    }
    catch (e) {
      print(e);
    }
  }

  modifyReview(String message, String rating, String prof_id) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      await dio.put('http://10.0.2.2:8000/prof/', data: {
        'message': message,
        'rating': int.parse(rating),
        'prof_id': int.parse(prof_id)
      });
    }
    catch (e) {
      print(e);
    }
  }

  Future<void> deleteReview(String user_id, String prof_id) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      await dio.delete('http://10.0.2.2:8000/prof/delete_review', data: {
        "user_id": user_id,
        "prof_id": prof_id
      });
      print('Review deleted.');
    }
    catch (e) {
      print(e);
    }
  }
}