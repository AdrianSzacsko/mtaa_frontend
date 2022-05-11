import 'dart:collection';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mtaa_frontend/Models/subj.dart';
import 'package:mtaa_frontend/constants.dart';
import 'package:mtaa_frontend/key.dart';

import '../../Models/prof.dart';
import '../../Models/profile.dart';
import '../../Models/respPlainPing.dart';

class FutureQueue{
  Queue queue = Queue();
  int delay;

  void push(var object){
    queue.add(object);
  }

  seek(){   //dynamic seek(){
    return queue.first;
  }

  dynamic pop(){
    return queue.removeFirst();
  }

  dynamic pushToFirst(var object){
    queue.addFirst(object);
  }

  bool isEmpty(){
    return queue.isEmpty;
  }

  FutureQueue(this.delay);

  Future<void> start() async {
    print("im started");
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