import 'package:flutter/material.dart';
import '../constants.dart';


Widget userInput(TextEditingController userInput, BuildContext context) {
  return Material(
    //elevation: 10,
    //borderRadius: const BorderRadius.all(Radius.circular(25.0)),
    //color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: Form(
             child: Container(
               decoration: BoxDecoration(
                   color: Colors.white, borderRadius: BorderRadius.circular(30)),
               child: Padding(
                 padding: const EdgeInsets.only(left: defaultPadding,
                     top: defaultPadding, right: defaultPadding),
                 child: TextFormField(
                   onEditingComplete: () => FocusScope.of(context).nextFocus(),
                   controller: userInput,
                   autocorrect: false,
                   enableSuggestions: false,
                   autofocus: false,
                   keyboardType: TextInputType.emailAddress,
                   obscureText: false,
                   decoration: InputDecoration(hintText: "Search for any subject, professor, user...",
                     hintStyle: const TextStyle(color: backgroundText, fontFamily: 'RobotoMono', fontSize: 16),
                     prefixIcon: const Padding(
                       padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                       child: Icon(Icons.search_outlined),
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderSide: const BorderSide(color: primaryColor),
                       borderRadius: BorderRadius.circular(25.0),
                     ),
                     focusedBorder:OutlineInputBorder(
                       borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                       borderRadius: BorderRadius.circular(25.0),
                     ),
                     errorBorder: OutlineInputBorder(
                       borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                       borderRadius: BorderRadius.circular(25.0),
                     ),
                     disabledBorder: OutlineInputBorder(
                       borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                       borderRadius: BorderRadius.circular(25.0),
                     ),
                     border: OutlineInputBorder(
                       borderSide: const BorderSide(color: primaryColor),
                       borderRadius: BorderRadius.circular(25.0),
                     ),
                     focusedErrorBorder: OutlineInputBorder(
                       borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                       borderRadius: BorderRadius.circular(25.0),
                     ),
                   ),
                 ),
               ),
             ),
            ),
          ),
        ),
      ],
    ),
  );
}