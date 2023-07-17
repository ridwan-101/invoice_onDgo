// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:invoice_ondgo/widget/status.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'business_registration_state.dart';

class BusinessRegistrationCubit extends Cubit<BusinessRegistrationState> {
  BusinessRegistrationCubit(this.context)
      : super(const BusinessRegistrationState());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController businessNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  TextEditingController otpController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  BuildContext context;
  String? currency;
  String? userId;

  storeBusinessId(String businessId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('businessId', businessId);
    print('yes');
  }

  Future<String?> registration(
    String businessName,
    String businessLocation,
    String accountName,
    String bank,
    String accountNumber,
    String phoneNumber,
    String stat,
    String? currency,
    String? userId,
  ) async {
    final body = {
      'businessName': businessName,
      'businessLocation': businessLocation,
      'accountName': accountName,
      'bank': bank,
      'accountNumber': accountNumber,
      'phoneNumber': phoneNumber,
      'state': stat,
      'currency': 0,
      'userId': userId,
    };

    try {
      Response response = await post(
        Uri.parse(
            'https://invoice-generator-walure-tap.azurewebsites.net/api/Business/CreateBusiness'),
        body: jsonEncode(body),
        headers: {'Content-type': 'application/json; charset=utf-8'},
      );

      if (response.statusCode == 200) {
        emit(state.copyWith(status: Status.success));
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Business Registration Successful'),
            duration: Duration(seconds: 2),
          ),
        );
        print(data['payload']['id']);
        String businessId = data['payload']['id'];
        businessId != null || businessId != ''
            ? storeBusinessId(businessId)
            : null;

        return data['payload']['id'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Business registration failed'),
            duration: Duration(seconds: 2),
          ),
        );
        print('Business reg failed');
      }
    } catch (e) {
      print('An error occurred: ${e.toString()}');
    }
  }

  void signup(
    String email,
    String password,
    String confirmPassword,
  ) async {
    // emit(state.copyWith(status: Status.loading));
    final body = {
      'email': email,
      'password': password,
      'confirmPassword': password,
    };

    try {
      Response response = await post(
        Uri.parse(
            'https://invoice-generator-walure-tap.azurewebsites.net/api/InvoiceAuth/Sign-Up'),
        body: jsonEncode(body),
        headers: {'Content-type': 'application/json; charset=utf-8'},
      );
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
        print('SignUp successful');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Otp Not Sent'),
            duration: Duration(seconds: 2),
          ),
        );
        print('Signup failed');
      }
    } catch (e) {
      print('An error occurred: ${e.toString()}');
    }
  }

  Future<String?> authenticateOtp(String otpCode, String email) async {
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
      print(response.body);
      if (response.statusCode == 200) {
        emit(state.copyWith(status: Status.success));
        var data = jsonDecode(response.body.toString());
        final userId = data['payload']['userId'];

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP code Validated'),
            duration: Duration(seconds: 2),
          ),
        );
        return userId;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
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

  Future<void> resendOtp(String email) async {
    final url =
        'https://invoice-generator-walure-tap.azurewebsites.net/api/InvoiceAuth/Resend-Otp?email=$email';

    try {
      final response = await http.get(Uri.parse(url));

      print(response.statusCode);
      if (response.statusCode == 200) {
        // OTP resent successfully
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP Resent'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // OTP resend failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to resend OTP'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Error occurred during API request
      print('An error occurred: ${e.toString()}');
    }
  }
}
