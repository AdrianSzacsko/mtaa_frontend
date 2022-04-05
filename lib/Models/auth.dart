/*
* this dart file made by: https://github.com/tommybarral/Sign-in-up
*/

import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../key.dart';

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

  Future<void> login(String email, String password) async {
    final url = Uri.parse(urlLogin + apiKey);
    final response = await http.post(url, headers: {'Content-Type': 'application/json',
                                                    'Accept': 'application/json',
                                                    },body: json.encode({
      'username': email,
      'password': password
      //'returnSecureToken': true,
    }));
    print(json.decode(response.body));
  }
}