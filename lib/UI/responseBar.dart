import 'package:flutter/material.dart';

responseBar(String text, Color? color, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        text,
        //textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}