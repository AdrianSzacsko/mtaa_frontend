import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mtaa_frontend/UI/InputField.dart';
import 'package:mtaa_frontend/Screens/welcome_screen.dart';
import 'package:mtaa_frontend/UI/temp_inputField.dart';


class SearchScreen extends StatelessWidget {

  static const routeName = '/search-screen';
  final searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: IconButton(
          icon: const Icon(Icons.home_rounded,
              color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => WelcomeScreen()));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search,
                color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.lightBlueAccent,
        child: Stack(
          children: [
            Container(
              height: 100,
              alignment: Alignment.center,
              child: Align(
                child: Form(
                  child: tempuserInput(searchController,

                  //Calling inputField  class
                    const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    "Search..."),
                ),
              ),
            ),
            Container(
              height: 220,
                child: Align(
                  //alignment: Alignment.topCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        print(searchController.text);
                        searchController.text = '';
                      },
                      child: const Text("Search"),
                    ),
                ),
            )
          ],
        ),
      )
    );
  }
}