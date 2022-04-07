import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Widget userInput(TextEditingController userInput, Widget icon, String hintText) {
  return Container(
    //width: 400,
    child: Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: icon,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            width: 348,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: TextField(
                  //TestField
                  controller: userInput,

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}