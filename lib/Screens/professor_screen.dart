import 'package:flutter/material.dart';
import 'package:mtaa_frontend/UI/appbar.dart';

import '../Models/profile.dart';
import '../constants.dart';
import '../Screens/profile_page.dart';

class ProfessorScreen extends StatelessWidget {
  ProfessorScreen({required this.title});
  final String title;

  Widget buildImage() {
    const image = const NetworkImage('https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80');

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          // child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildName(String name) => Column(
    children: [
      Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
    ],
  );

  Widget buildInfo(String value) => Container(
    padding: const EdgeInsets.symmetric(),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.star_outlined,
              color: primaryColor,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(value,
                style: TextStyle(fontSize: 16,),
              ),
            ),
          ],
        )
      ]
    ),
  );

  Widget buildButton(String value) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildInfo(value)
          ],
        ),
      );



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
            const SizedBox(height: defaultPadding * 2),
            Center(
              child: Stack(
                children: [
                  buildImage(),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding * 2),
            buildName("GALINSKI"),
            const SizedBox(height: defaultPadding * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildButton("65"),
              ],
            ),
            const SizedBox(height: defaultPadding * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(defaultPadding * 2,
                      defaultPadding * 2, defaultPadding * 2,
                      defaultPadding),
                  child: Text(
                    'Reviews',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(defaultPadding * 2,
                      defaultPadding * 2, defaultPadding * 2,
                      defaultPadding),
                  child: buildInfo("80"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(defaultPadding * 2,
                      defaultPadding * 2, defaultPadding * 2,
                      defaultPadding),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox.fromSize(
                      size: Size(56, 56), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: secondaryColor[300], // button color
                          child: InkWell(
                            splashColor: primaryColor[300], // splash color
                            onTap: () {}, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(Icons.add_outlined), // icon
                                //Text("Add"), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation:5,
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