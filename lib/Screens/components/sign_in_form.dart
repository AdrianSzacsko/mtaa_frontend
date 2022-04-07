import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants.dart';

class SignInForm extends StatelessWidget {
  SignInForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;

  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height:defaultPadding * 4),
          // TextFieldName(text: "Email"),
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
            validator: EmailValidator(errorText: "Use a valid email!"),
            onSaved: (email) => _email = email!,

          ),
          const SizedBox(height: defaultPadding),
          // TextFieldName(text: "Password"),
          TextFormField(
            // We want to hide our password
            obscureText: true,
            decoration: InputDecoration(hintText: "Password",
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
            validator: passwordValidator,
            onSaved: (password) => _password = password!,
          ),
          const SizedBox(height: defaultPadding * 2),
        ],
      ),
    );
  }
}