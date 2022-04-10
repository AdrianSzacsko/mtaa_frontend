import 'package:flutter/material.dart';
import 'package:mtaa_frontend/UI/appbar.dart';

import '../Models/profile.dart';
import '../constants.dart';
import '../Screens/profile_page.dart';

class ProfessorScreen extends StatelessWidget {
  ProfessorScreen({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context),
        bottomNavigationBar: myBottomAppBar(context),
        body: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            ProfessorReview(
                name: "iPhone",
                description: "iPhone is the stylist phone ever",
                price: 1000,
                image: "puzzle.png",
            ),

            ProfessorReview(
                name: "Pixel",
                description: "Pixel is the most featureful phone ever",
                price: 800,
                image: "puzzle.png",
            ),

            ProfessorReview(
                name: "Laptop",
                description: "Laptop is most productive development tool",
                price: 2000,
                image: "puzzle.png",
            ),
            ProfessorReview(
                name: "Tablet",
                description: "Tablet is the most useful device ever for meeting",
                price: 1500,
                image: "puzzle.png",
            ),
            ProfessorReview(
                name: "Pendrive",
                description: "Pendrive is useful storage medium",
                price: 100,
                image: "puzzle.png",
            ),
            ProfessorReview(
                name: "Floppy Drive",
                description: "Floppy drive is useful rescue storage medium."
                    "Floppy drive is useful rescue storage medium."
                    "Floppy drive is useful rescue storage medium."
                    "Floppy drive is useful rescue storage medium."
                    "Floppy drive is useful rescue storage medium."
                    "Floppy drive is useful rescue storage medium.",
                price: 20,
                image: "puzzle.png",
            ),
          ],
        )
    );
  }
}

class ProfessorReview extends StatelessWidget {
  ProfessorReview({required this.name, required this.description, required this.price, required this.image});
  final String name;
  final String description;
  final int price;
  final String image;
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                      child: Image.asset('assets/Images/' + image,
                        height: 80.0,
                        fit: BoxFit.cover,
                      )
                  ),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                  this.name, style: const TextStyle(
                                  fontWeight: FontWeight.bold
                              )
                              ),
                              Text(this.description), Text(
                                  "Price: " + this.price.toString()
                              ),
                            ],
                          )
                      )
                  )
                ]
            )
        )
    );
  }
}