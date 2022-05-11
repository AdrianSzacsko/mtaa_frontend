/*
* this dart file made by: https://github.com/tommybarral/Sign-in-up
*/

import 'dart:io';
import 'package:hive/hive.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../key.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Auth with ChangeNotifier {
  Future<void> signup(String email, String firstname, String lastname, int study_year, String password) async {
    final url = Uri.parse(urlRegister + apiKey);
    final response = await http.post(url, body: json.encode({
      'email': email,
      'first_name': firstname,
      'last_name': lastname,
      'study_year': study_year,
      'password': password,
      //'returnSecureToken': true,
    }));
    print(json.decode(response.body));
  }


  register(String email, String firstname, String lastname, int studyYear, String password) async {
    var response;
    var dio = Dio();
    // dio.options.headers['Authorization'] = 'Bearer '+ token;
    // dio.options.headers['Content-Type'] = 'application/json';
    try {
      response = await dio.post(urlRegister + apiKey, data: {
        'email': email,
        'first_name': firstname,
        'last_name': lastname,
        'study_year': studyYear,
        'pwd': password
      });
      //print(response.data);
      return response;
    }
    on DioError catch (e) {
      //print(e.response?.statusCode);
      return e.response;
    }
  }



  login(String email, String password)async{
    var response;
    var dio = Dio();
    dio.options.headers['content-Type'] = "application/x-www-form-urlencoded";
    try {
      FormData formData = FormData.fromMap({
        'grant_type': 'password',
        'client_id': null,
        'client_secret': null,
        'username': email,
        'password': password,
      });
      response = await dio.post(urlLogin + apiKey, data: formData);

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data["access_token"]);
        Map<String, dynamic> payload = Jwt.parseJwt(response.data["access_token"]);
        prefs.setInt('user_id', payload["user_id"]);
      }

      return response;
    }
    on DioError catch (e) {
      //print(e.response?.statusCode);
      return e.response;
    }
  }
}
