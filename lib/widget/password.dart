// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  PasswordTextField({required this.controller});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password is required";
        }

        if (value.length < 8) {
          return "Password must be at least 8 characters long";
        }

        if (!value.contains(RegExp(r'[A-Z]'))) {
          return "Password must contain at least one capital letter";
        }

        if (!value.contains(RegExp(r'[a-z]'))) {
          return "Password must contain at least one small letter";
        }

        if (!value.contains(RegExp(r'[0-9]'))) {
          return "Password must contain at least one number";
        }

        if (!value.contains(RegExp(r'[^A-Za-z0-9]'))) {
          return "Password must contain only one special character";
        }

        return null;
      },
      decoration: InputDecoration(
        filled: true, // Enable fill color
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x8098F980), // Set the border color here
          ),
        ),
        prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.blue[100]),
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.blue[100]),
        suffixIcon: IconButton(
          icon: _obscureText
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          color: Colors.blue[100],
        ),
      ),
    );
  }
}

class ConfirmPasswordField extends StatefulWidget {
  final TextEditingController controller;

  ConfirmPasswordField({super.key, required this.controller});

  @override
  State<ConfirmPasswordField> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for Login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password (Min. 6 Character)");
        }
      },
      decoration: InputDecoration(
        filled: true, // Enable fill color
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x8098F980), // Set the border color here
          ),
        ),
        prefixIcon: Icon(
          Icons.shield_sharp,
          color: Colors.blue[100],
          size: 30,
        ),
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.blue[100]),
        suffixIcon: IconButton(
          icon: _obscureText
              ? Icon(
                  Icons.visibility_off,
                  size: 30,
                )
              : Icon(
                  Icons.visibility,
                  size: 30,
                ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          color: Colors.blue[100],
        ),
      ),
    );
  }
}
