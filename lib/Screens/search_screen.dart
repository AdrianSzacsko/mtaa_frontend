import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mtaa_frontend/Screens/profile_screen.dart';
//import 'package:flutter/rendering.dart';
import 'package:mtaa_frontend/UI/inputField.dart';
import 'package:mtaa_frontend/Screens/sign_in_screen.dart';
import 'package:mtaa_frontend/Screens/settings_screen.dart';

import '../UI/appbar.dart';
import '../constants.dart';

class SearchScreen extends StatefulWidget {
  //SearchScreen({Key key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  bool _isloading = false;

  ScrollController scrollController = ScrollController();

  static const routeName = '/search-screen';
  final searchController = TextEditingController();
  //List<String> row = <String>['name','code','id'];
  List<List<String>> list_of_rows = <List<String>>[['Mobilné technológie a Aplikácie','MTAA','5'],
    ['Marko Stahovec','USER','5'],
    ['Ing. Marek Galinski','PROF','5']];


  @override
  void inisState() {
    super.initState();
    dataLoadFunction();
  }

  dataLoadFunction() async {
    setState(() {
      _isloading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    //fetch data here
    setState(() {
      _isloading = false;
    });
  }


  Widget buildList() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height -276,
      child: Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
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
        ),
      )

    );
  }

  BouncingScrollPhysics bouncingScrollPhysics = BouncingScrollPhysics();

  Widget _buildRow(List<String> row) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding (
        padding: EdgeInsets.all(5),
        child: ListTile(
            title: Text(row[0], style: TextStyle(fontSize: 18.0, color: mainTextColor)),
            trailing: Icon(row[1] == 'PROF' ? Icons.work_rounded :
            row[1] == 'USER' ? Icons.account_circle_rounded :
            Icons.article_rounded,
                color: primaryColor[300]),
            onTap: () {
              print(row);
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context),
        bottomNavigationBar: myBottomAppBar(context),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: backgroundColor,
            child: Column(
              children: [
                Container(
                  height: 100,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.all(5.0),
                  child: Align(
                    child: Form(
                      child: userInput(searchController, //Calling inputField  class
                          const Icon(
                            Icons.search_outlined,
                            color: backgroundText,
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
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      color:secondaryColor[300],
                      onPressed: () {
                        setState(() {
                          dataLoadFunction();
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
                ),
              ],
            ),
          ),
          _isloading ? Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: secondaryColor,
            ),
          ): const SizedBox.shrink(),
        ],
      ),


    );
  }
}