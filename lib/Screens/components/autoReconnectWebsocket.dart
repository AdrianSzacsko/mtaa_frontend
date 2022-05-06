//autoreconnecting implemented from: https://stackoverflow.com/questions/55503083/flutter-websockets-autoreconnect-how-to-implement

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mtaa_frontend/Database/SearchModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../Database/operations.dart';

class AutoReconnectWebSocket{
  final Uri _endpoint;
  final int delay;
  final StreamController<dynamic> _recipientCtrl = StreamController<dynamic>();
  final StreamController<dynamic> _sentCtrl = StreamController<dynamic>();

  late DatabaseHandler handler;

  bool isSearched = false;
  String searchString = "";

  IOWebSocketChannel? webSocketChannel;

  get stream => _recipientCtrl.stream;

  get sink => _sentCtrl.sink;

  AutoReconnectWebSocket(this._endpoint, {this.delay = 1}) {
    _sentCtrl.stream.listen((event) {
      webSocketChannel!.sink.add(event);
    });
    _connect();
    handler = DatabaseHandler();
  }

  void setSearched() {
    isSearched = true;
  }

  void unsetSearched() {
    isSearched = false;
  }

  void setSearchString(String text){
    searchString = text;
  }


  getToken() async {
    return await SharedPreferences.getInstance();
  }

  createresponse() async{
    List<SearchDB> data = await handler.retrieveSearch(searchString);
    print("searching");
    List<Map> temp = <Map>[];
    data.forEach((element) {
      temp.add(element.toMap());
    });
    Map<String, dynamic> map = {'status_code': 200, 'message': json.encode(temp)};
    return json.encode(map);
  }

  Future<void> _connect() async {
    var prefs = await getToken();
    final token = prefs.getString('token') ?? '';
    webSocketChannel = IOWebSocketChannel.connect(_endpoint, headers: {HttpHeaders.authorizationHeader: ("Bearer " + token)});
    webSocketChannel!.stream.listen((event) {
      _recipientCtrl.add(event);
    }, onError: (e) async {
      _recipientCtrl.addError(e);
      if (isSearched == true) {
        isSearched = false;
        _recipientCtrl.add(await createresponse());
      }
      
      await Future.delayed(Duration(seconds: delay));
      _connect();
    }, onDone: () async {
      await Future.delayed(Duration(seconds: delay));
      _connect();
    }, cancelOnError: true);
  }
}