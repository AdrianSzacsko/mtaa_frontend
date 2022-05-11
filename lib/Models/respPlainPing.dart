import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../key.dart';

class Plain with ChangeNotifier {
  Future<bool> getPlain() async {
    var response;

    var dio = Dio();

    try {
      response = await dio.get(urlKey);
    }

    on DioError catch (e) {
      response = e.response;
    }
    if (response == null){
      return false;
    }
    return true;
  }
}