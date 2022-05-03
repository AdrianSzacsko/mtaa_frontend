//autoreconnecting implemented from: https://stackoverflow.com/questions/55503083/flutter-websockets-autoreconnect-how-to-implement

import 'dart:async';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AutoReconnectWebSocket{
  final Uri _endpoint;
  final int delay;
  final StreamController<dynamic> _recipientCtrl = StreamController<dynamic>();
  final StreamController<dynamic> _sentCtrl = StreamController<dynamic>();

  IOWebSocketChannel? webSocketChannel;

  get stream => _recipientCtrl.stream;

  get sink => _sentCtrl.sink;

  AutoReconnectWebSocket(this._endpoint, {this.delay = 5}) {
    _sentCtrl.stream.listen((event) {
      webSocketChannel!.sink.add(event);
    });
    _connect();
  }

  getToken() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> _connect() async {
    var prefs = await getToken();
    final token = prefs.getString('token') ?? '';
    webSocketChannel = IOWebSocketChannel.connect(_endpoint, headers: {HttpHeaders.authorizationHeader: ("Bearer " + token)});
    webSocketChannel!.stream.listen((event) {
      _recipientCtrl.add(event);
    }, onError: (e) async {
      _recipientCtrl.addError(e);
      await Future.delayed(Duration(seconds: delay));
      _connect();
    }, onDone: () async {
      await Future.delayed(Duration(seconds: delay));
      _connect();
    }, cancelOnError: true);
  }
}