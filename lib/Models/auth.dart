/*
* this dart file made by: https://github.com/tommybarral/Sign-in-up
*/

import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../key.dart';
import 'package:dio/dio.dart';

class Auth with ChangeNotifier {

  Future<void> signup(String email, String firstname, String lastname, int study_year, String password) async {
    final url = Uri.parse(urlAuth + apiKey);
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

  /*
  Future<void> login(String email, String password) async {
    var map = <String, dynamic>{};
    map['grant_type'] = 'password';
    map['client_id'] = null;
    map['client_secret'] = null;
    map['username'] = email;
    map['password'] = password;
    final url = Uri.parse(urlLogin + apiKey);
    http.Response response = await http.post(url, body: {
      'grant_type': 'password',
      'client_id': null,
      'client_secret': null,
      'username': email,
      'password': password,
    });
    print(map);
  }*/

  login(String email, String password)async{
    var dio = Dio();
    var body = <String, dynamic>{};
    body['grant_type'] = 'password';
    body['client_id'] = null;
    body['client_secret'] = null;
    body['username'] = email;
    body['password'] = password;
    try {
      FormData formData = FormData.fromMap(body);
      var response = await dio.post(urlLogin + apiKey, data: formData);
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
