import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../key.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Search with ChangeNotifier {
  Future<List<List<String>>?> search(String searchString) async {
    Response response;

    var dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['Authorization'] = "Bearer" + token;

    print("------------------------------------------");
    print(token);

    /*
    var t = token;
    if (t != null) {
      dio.options.headers['Authorization'] = "Bearer" + t;
    }*/


    try {
      response = await dio.get('http://10.0.2.2:8000/search?search_string=' + searchString);
      print(response.data);
      return response.data;
    }
    catch (e) {
      print(e);
    }

    return null;
  }
}