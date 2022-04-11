import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SubjectClass with ChangeNotifier {
  Future<dynamic> getSubject(String subj_id) async {
    Response response;

    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      response = await dio.get('http://10.0.2.2:8000/subj/' + subj_id);
      print(response.data);
      return response.data;
    }
    catch (e) {
      print(e);
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
      response = await dio.get('http://10.0.2.2:8000/subj/' + subj_id + "/reviews");
      print(response.data);
      return response.data;
    }
    catch (e) {
      print(e);
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
      var response = await dio.post('http://10.0.2.2:8000/subj/', data: {
        'message': message,
        'difficulty': int.parse(difficulty),
        'usability': int.parse(usability),
        'prof_avg': int.parse(prof_avg),
        'subj_id': int.parse(subj_id)
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

  modifyReview(String message, String difficulty,
      String usability, String prof_avg, String subj_id) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      await dio.put('http://10.0.2.2:8000/subj/', data: {
        'message': message,
        'difficulty': int.parse(difficulty),
        'usability': int.parse(usability),
        'prof_avg': int.parse(prof_avg),
        'subj_id': int.parse(subj_id)
      });
    }
    catch (e) {
      print(e);
    }
  }

  Future<void> deleteReview(String user_id, String subj_id) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      await dio.delete('http://10.0.2.2:8000/subj/delete_review', data: {
        "user_id": user_id,
        "subj_id": subj_id
      });
      print('Review deleted.');
    }
    catch (e) {
      print(e);
    }
  }
}