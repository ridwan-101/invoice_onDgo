// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors, depend_on_referenced_packages, unnecessary_null_comparison

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:invoice_ondgo/widget/status.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.context) : super(const SigninState());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  BuildContext context;
  String? token;

  // login
  storeTokenId(String tokenn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tokenn', tokenn);
    print('yes');
  }

  login(email, password) async {
    emit(state.copyWith(status: Status.loading));
    final body = {
      'email': email,
      'password': password,
    };

    final headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Authorization': "Bearer $token",
    };

    try {
      Response response = await post(
        Uri.parse(
            'https://invoice-generator-walure-tap.azurewebsites.net/api/InvoiceAuth/login'),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        emit(state.copyWith(status: Status.success));
        var data = jsonDecode(response.body.toString());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful'),
            duration: Duration(seconds: 2),
          ),
        );
        print(data);

        token = data['payload'];

        String tokenn = data['payload'];
        tokenn != null || tokenn != '' ? storeTokenId(tokenn) : null;

        print('Login successful');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email or Password Not Correct'),
            duration: Duration(seconds: 2),
          ),
        );
        print('Login failed');
      }
    } catch (e) {
      print('An error occurred: ${e.toString()}');
    }
  }

  // forgetPassword
  void forgetPassword(String email) async {
    emit(state.copyWith(status: Status.loading));

    final body = {
      'email': email,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'https://invoice-generator-walure-tap.azurewebsites.net/api/InvoiceAuth/Forgot-Password'),
        body: jsonEncode(body),
        headers: {'Content-type': 'application/json; charset=utf-8'},
      );

      print(response.statusCode);
      print(body);
      if (response.statusCode == 200) {
        emit(state.copyWith(status: Status.success));
        var data = jsonDecode(response.body.toString());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP Sent'),
            duration: Duration(seconds: 2),
          ),
        );

        print(data['token']);
        print('OTP sent');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send OTP'),
            duration: Duration(seconds: 2),
          ),
        );
        print('');
      }
    } catch (e) {
      print('An error occurred: ${e.toString()}');
    }
  }

  void forgetPasswordOtp(String otpCode, String email) async {
    final body = {
      "key": email,
      'verifiedOTP': otpCode,
    };

    try {
      Response response = await post(
        Uri.parse(
            'https://invoice-generator-walure-tap.azurewebsites.net/api/InvoiceAuth/Verify-Otp'),
        body: jsonEncode(body),
        headers: {'Content-type': 'application/json; charset=utf-8'},
      );

      print(jsonEncode(body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        emit(state.copyWith(status: Status.success));
        var data = jsonDecode(response.body.toString());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verified'),
            duration: Duration(seconds: 2),
          ),
        );

        print(data['token']);
        print('OTP authentication successful');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid OTP code'),
            duration: Duration(seconds: 2),
          ),
        );
        print('OTP authentication failed');
      }
    } catch (e) {
      print('An error occurred: ${e.toString()}');
    }
  }

  Future<void> updatePassword(
      String email, String password, String confirmPassword) async {
    const url =
        'https://invoice-generator-walure-tap.azurewebsites.net/api/InvoiceAuth/Reset-Password';

    final body = {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };

    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-type': 'application/json; charset=utf-8'},
      body: jsonEncode(body),
    );
    print(jsonEncode(body));
    if (response.statusCode == 200) {
      emit(state.copyWith(status: Status.success));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password Updated'),
          duration: Duration(seconds: 2),
        ),
      );

      print('Password updated');
      print(response.statusCode);
    } else {
      // Error occurred
      print('Failed to update password. Status code: ${response.statusCode}');
    }
  }

  Future<void> resendOtp(String email) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://invoice-generator-walure-tap.azurewebsites.net/api/InvoiceAuth/Resend-Otp?email=$email'),
        headers: {'Content-type': 'application/json; charset=utf-8'},
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        // Resend successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Otp resend successful'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Resend failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Otp resend failed'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('An error occurred: ${e.toString()}');
    }
  }
}
