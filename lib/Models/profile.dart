import 'dart:ffi';
import 'dart:io';
//import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';


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

    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.jpg').create();
    file.writeAsBytesSync(bytes);

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path,
          filename:'image.jpg',
          contentType: MediaType('image','jpg')),
    });

    var formData2 = http.MultipartFile(
        'file',
        Stream.value(List<int>.from(bytes)),
        bytes.lengthInBytes,
        filename: 'untitled',
        contentType: MediaType('image','jpg'));
  //bytes.buffer.asByteData();
  //Latin1Decoder().convert(bytes);
    //Latin1Decoder().convert(bytes)
    try {
      Response response = await dio.put('http://10.0.2.2:8000/profile/pic', data: formData);

      print('Profile updated: ${response.data}');

    } catch (e) {
      print('Error updating profile: $e');
    }

    return null;
  }
}