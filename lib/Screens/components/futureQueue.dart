import 'dart:collection';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mtaa_frontend/Models/subj.dart';
import 'package:mtaa_frontend/constants.dart';
import 'package:mtaa_frontend/key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/prof.dart';
import '../../Models/profile.dart';
import '../../Models/respPlainPing.dart';

class FutureQueue{
  late String codeName;
  //late String token;
  final box = GetStorage();
  bool isInit = false;
  bool isLoggedIn = false;

  Queue queue = Queue();
  int delay;

  void relog(){
    isInit = false;
    isLoggedIn = true;
  }

  void signOut(){
    queue.clear();
    isLoggedIn = false;
  }

  void deleteQueue(){
    queue.clear();
  }

  void push(var object){
    queue.add(object);
    box.write(codeName, toJson());
  }



  toJson(){
    var list = queue.toList();
    for (var i = 0; i < list.length; i++){
      var element = list.elementAt(i);
      list.removeAt(i);
      list.insert(i, {"method": element["method"].index,"params": element["params"]});
    }
    /*Map dict = {};
    list.forEach((element) {
    });*/
    return list;
  }

  fromJson(var dict){
    var list = dict;
    queue.clear();
    for (var i = 0; i < list.length; i++){
      var element = list.elementAt(i);
      queue.add({"method": ResponseMethods.values[element["method"]],"params": element["params"]});
    }

  }




  seek(){   //dynamic seek(){
    return queue.first;
  }

  dynamic pop(){
    box.write(codeName, toJson());
    return queue.removeFirst();
  }

  dynamic pushToFirst(var object){
    queue.addFirst(object);
  }

  bool isEmpty(){
    return queue.isEmpty;
  }

  FutureQueue(this.delay);

  Future init() async {
    var prefs = await SharedPreferences.getInstance();
    //token = prefs.getString('token') ?? '';
    var user_id = prefs.getInt('user_id') ?? 0;
    codeName = 'user/' + user_id.toString();
    print(codeName);
    //read queue
    var temp = box.read(codeName) ?? Queue();
    fromJson(temp);
    print("init_queue");
  }

  Future<void> start() async {
    if (isLoggedIn == false){
      return;
    }
    if (isInit == false){
      await init();
      isInit = true;
    }
    print("im started");
    if (isEmpty() == false) {
      if (await Plain().getPlain() == true){
        print("pinged");
        while (isEmpty() == false){
          print("not empty");

          //execute REST call
          var response = await _executeCall();
          if (response != null){
            pop();

          }
          else{
            //an error has occured
            break;
          }

        }
        //we have connection
      }
    }

    //connection failed
    /*
    await Future.delayed(Duration(seconds: delay));
    _start();
     */
  }

  _executeCall() async {
    var response = null;
    var object = seek();
    if (object["method"] == ResponseMethods.DeleteProfessorReview){
      response = await ProfessorClass().deleteReview(
          object["params"][0],
          object["params"][1]
      );
    }
    else if (object["method"] == ResponseMethods.DeleteSubjectReview){
      response = await SubjectClass().deleteReview(
          object["params"][0],
          object["params"][1]
      );
    }
    else if (object["method"] == ResponseMethods.DeletePic){
      response = await Profile().deleteProfilePic();
    }
    else if (object["method"] == ResponseMethods.PostProfessorReview){
      response = await ProfessorClass().postReview(
          object["params"][0],
          object["params"][1],
          object["params"][2]
      );

    }
    else if (object["method"] == ResponseMethods.PostSubjectReview){
      response = await SubjectClass().postReview(
          object["params"][0],
          object["params"][1],
          object["params"][2],
          object["params"][3],
          object["params"][4]
      );

    }
    else if (object["method"] == ResponseMethods.PutMyUserPic){
      response = await Profile().putProfilePic(bytes: object["params"][0]);
    }
    else if (object["method"] == ResponseMethods.PutProfessorReview){
      response = await ProfessorClass().modifyReview(
          object["params"][0],
          object["params"][1],
          object["params"][2]
      );

    }
    else if (object["method"] == ResponseMethods.PutSubjectReview){
      response = await SubjectClass().modifyReview(
          object["params"][0],
          object["params"][1],
          object["params"][2],
          object["params"][3],
          object["params"][4]
      );

    }
    return response;
  }
}