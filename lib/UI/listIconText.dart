import 'package:flutter/material.dart';

Widget listIconText(TextEditingController Text, String code) {
  return Container(
    //width: 400,
    child: Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
              (code == 'USER') ?
                const Icon(
                  Icons.account_circle_rounded
                ):
                (code == 'PROF') ?
                  const Icon(
                    Icons.work_rounded
                  ):
                    const Icon(
                      Icons.article_rounded
                    )
            ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
            ),
            width: 350,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: TextField(
                  //TestField
                  controller: Text,

                  /*decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    fillColor: Colors.white,
                    filled: true,
                  ),*/
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