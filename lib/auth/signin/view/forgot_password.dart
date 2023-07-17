// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_ondgo/auth/signin/logic/cubit/signin_cubit.dart';
import 'package:invoice_ondgo/auth/signin/view/otp_for_forgot_password.dart';

import 'package:invoice_ondgo/widget/email.dart';
import 'package:invoice_ondgo/widget/loginbutton.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state.success) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => SigninCubit(context),
                child: OtpForForgotPasswordPage(
                  emailController: emailController.text,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 2, 79, 141),
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Color.fromARGB(255, 2, 79, 141),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/On_the_go.png'),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70),
                      Text(
                        'Forget Password?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Please enter your email to get OTP code',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      EmailTextField(controller: emailController),
                      SizedBox(height: 20),
                      LoginButton(
                        width: 390,
                        height: 100,
                        text: 'GET OTP',
                        color: Colors.white,
                        textColor: Color.fromARGB(255, 0, 88, 161),
                        loading: false,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SigninCubit>().forgetPassword(
                                  emailController.text.toString(),
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
