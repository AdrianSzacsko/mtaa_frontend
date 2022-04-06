import 'dart:ffi';

import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:mtaa_frontend/Screens/welcome_screen.dart';
import 'package:mtaa_frontend/UI/inputField.dart';
import 'package:mtaa_frontend/UI/listIconText.dart';

class SearchScreen extends StatefulWidget {
  //SearchScreen({Key key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {

  static const routeName = '/search-screen';
  final searchController = TextEditingController();
  //List<String> row = <String>['name','code','id'];
  List<List<String>> list_of_rows = <List<String>>[['Mobilné technológie a Aplikácie','MTAA','5'],
    ['Marko Stahovec','USER','5'],
    ['Ing. Marek Galinski','PROF','5']];

  Widget buildList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(5.0),
      key: UniqueKey(),
      itemCount: list_of_rows.isEmpty ? 1 : list_of_rows.length,
      itemBuilder: (context, item) {
        if (list_of_rows.isEmpty) {
          list_of_rows.addAll([['Mobilné technológie a Aplikácie','MTAA','5'],
            ['Marko Stahovec','USER','5'],
            ['Ing. Marek Galinski','PROF','5']]);

        }
        //TODO add get method
        return _buildRow(list_of_rows[item]);
      },
    );
  }

  Widget _buildRow(List<String> row) {
    return ListTile(
        title: Text(row[0], style: TextStyle(fontSize: 18.0)),
        trailing: Icon(row[1] == 'PROF' ? Icons.work_rounded :
            row[1] == 'USER' ? Icons.account_circle_rounded :
            Icons.article_rounded,
            color: Colors.black),
        onTap: () {
          print(row);
        });
  }

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
        child: Column(
          children: [
            Container(
              height: 100,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(5.0),
              child: Align(
                child: Form(
                  child: userInput(searchController,

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
              //height: 200,
                child: Align(
                  alignment: Alignment.center,
                  //alignment: Alignment.topCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          list_of_rows.add(['Marko Stahovec','USER','5']);
                        });
                        print(searchController.text);
                        searchController.text = '';
                      },
                      child: const Text("Search"),
                    ),
                ),
            ),
            Container(
              alignment: Alignment.center,
              child: Align(
                alignment: Alignment.center,
                child: buildList(),
              ),
            )
            //buildList(),
            /*ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 60,margin: EdgeInsets.all(2),
                    color: Colors.white,
                    child: Center(
                      child: _buildList(),
                    ),
                  );
                }
            ),*/
          ],
        ),
      )
    );
  }
}