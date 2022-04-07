import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;

  late String _first_name, _email, _password, _last_name, _study_year;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextFieldName(text: "Email"),
          const SizedBox(height:defaultPadding * 2),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "Email",
              hintStyle: const TextStyle(color: backgroundText),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                child: Icon(Icons.email_outlined),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),),
            validator: EmailValidator(errorText: "Invalid email"),
            // Let's save our email
            onSaved: (email) => _email = email!,
          ),
          const SizedBox(height: defaultPadding),
          // We will fixed the error soon
          // As you can see, it's a email field
          // But no @ on keybord
          // TextFieldName(text: "First name"),
          TextFormField(
            decoration: InputDecoration(hintText: "Joseph",
              hintStyle: const TextStyle(color: backgroundText),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                child: Icon(Icons.account_circle_outlined),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),),
            validator: RequiredValidator(errorText: "First name is required"),
            onSaved: (first_name) => _first_name = first_name!,
          ),
          const SizedBox(height: defaultPadding),
          // TextFieldName(text: "Last name"),
          // Same for phone number
          TextFormField(
            decoration: InputDecoration(hintText: "Carrot",
              hintStyle: const TextStyle(color: backgroundText),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                child: Icon(Icons.account_circle_outlined),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),),
            validator: RequiredValidator(errorText: "Last name is required"),
            onSaved: (last_name) => _last_name = last_name!,
          ),
          const SizedBox(height: defaultPadding),
          // TextFieldName(text: "Password"),

          TextFormField(
            // We want to hide our password
            obscureText: true,
            decoration: InputDecoration(hintText: "******",
              hintStyle: const TextStyle(color: backgroundText),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                child: Icon(Icons.lock_outlined),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),),
            //validator: passwordValidator,
            onSaved: (password) => _password = password!,
            // We also need to validate our password
            // Now if we type anything it adds that to our password
            // onChanged: (pass) => _password = pass,
          ),
          const SizedBox(height: defaultPadding),
          // TextFieldName(text: "Study year"),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "1",
              hintStyle: const TextStyle(color: backgroundText),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                child: Icon(Icons.school_outlined),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: secondaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),),
            validator: RequiredValidator(errorText: "Study year is required"),
            onSaved: (study_year) => _study_year = study_year!,
          ),
        ],
      ),
    );
  }
}

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 3),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, color: textColor),
      ),
    );
  }
}