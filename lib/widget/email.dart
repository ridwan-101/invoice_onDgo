import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;

  EmailTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: 'Email',
        hintStyle: TextStyle(
          color: Colors.blue[100],
        ), // Set the hint text color here
        prefixIcon: Icon(
          Icons.email_outlined,
          color: Colors.blue[100],
          size: 30,
        ),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter your Email");
        }
        if (!RegExp("[a-zA-Z0-9+_.-]+@[a-zA-Z0-9]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid Email");
        }
        return null;
      },
    );
  }
}
