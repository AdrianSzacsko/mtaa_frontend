import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Profile with ChangeNotifier {
  Future<dynamic> getProfile(String profile_id) async {
    Response response;

    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;

    try {
      response = await dio.get('http://10.0.2.2:8000/profile/' + profile_id);
      print(response.data);
      return response.data;
    }
    catch (e) {
      print(e);
    }

    return null;
  }

  Future<dynamic> getProfilePic(String profile_id) async {
    Response response;

    var dio = Dio();
    dio.options.headers['content-Type'] = 'image/png';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;
    dio.options.headers['responseType'] = ResponseType.plain;

    try {
      response = await dio.get('http://10.0.2.2:8000/profile/' + profile_id + "/pic");
      print(response.data);
      return response.data;
    }
    catch (e) {
      print(e);
    }

    return null;
  }

  Future<dynamic> putProfilePic({
    required String profile_id,
    required Uint8List bytes,
  }) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'image/png';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dio.options.headers['authorization'] = "Bearer " + token;
    dio.options.headers['responseType'] = ResponseType.plain;

    try {
      Response response = await dio.put('http://10.0.2.2:8000/profile/' + profile_id + "/pic", data: bytes);

      print('Profile updated: ${response.data}');

    } catch (e) {
      print('Error updating profile: $e');
    }

    return null;
  }
}