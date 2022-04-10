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
      response =
      await dio.get('http://10.0.2.2:8000/subj/' + subj_id + "/reviews");
      print(response.data);
      return response.data;
    }
    catch (e) {
      print(e);
    }
  }
}