import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  Icon fieldIcon;
  String hintText;

  InputField(TextEditingController editingController, this.fieldIcon, this.hintText, {Key? key}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final _text = TextEditingController();
  final bool _validate = false;

  String result = '';

  getTextInputData() {
    setState(() {
      result = _text.text;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              child: widget.fieldIcon,
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
                    controller: _text,

                    decoration: InputDecoration(
                      errorText: _validate ? "Username" : null,
                      border: InputBorder.none,
                      hintText: widget.hintText,
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
}