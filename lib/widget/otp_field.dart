// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';


class Otp_field extends StatefulWidget {
  const Otp_field({super.key});

  @override
  State<Otp_field> createState() => _Otp_fieldState();
}

class _Otp_fieldState extends State<Otp_field> {
  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
      ),
      numberOfFields: 6,
      
      keyboardType: TextInputType.number,
      borderColor: Colors.white,
      focusedBorderColor: Colors.white,
      showFieldAsBox: true,
      fieldWidth: 50,
      textStyle: TextStyle(
        color: Colors.white,
      ),
       // Adjust the field width as needed
      // Adjust the field height as needed
      onCodeChanged: (String code) {},
      onSubmit: (String verificationCode) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Verification Code"),
              content: Text('Code entered is $verificationCode'),
            );
          },
        );
      },
    );
  }
}
