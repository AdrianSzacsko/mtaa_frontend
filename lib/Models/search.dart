import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../key.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Search with ChangeNotifier {
  var response;
  Future<Response?> search(String searchString) async {
    Response response;

    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;


    try {
      response = await dio.get(urlKey + 'search?search_string=' + searchString);
      print(response.data);
      return response;
    }
    on DioError catch (e) {
      //print(e.response?.statusCode);
      return e.response;
    }

    return null;
  }
}