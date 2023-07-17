// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors, use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_ondgo/auth/signin/logic/cubit/signin_cubit.dart';
import 'package:invoice_ondgo/auth/signin/view/enter_new_password.dart';
import 'package:invoice_ondgo/widget/loginbutton.dart';

class OtpForForgotPasswordPage extends StatefulWidget {
  final String emailController;

  const OtpForForgotPasswordPage({Key? key, required this.emailController})
      : super(key: key);

  @override
  State<OtpForForgotPasswordPage> createState() =>
      _OtpForForgotPasswordPageState();
}

class _OtpForForgotPasswordPageState extends State<OtpForForgotPasswordPage> {
  TextEditingController otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late Timer _timer;
  late StreamController<int> _streamController;
  late Stream<int> _stream;
  int _start = 180;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<int>();
    _stream = _streamController.stream;
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _streamController.close();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
        _streamController.sink.add(_start);
      }
    });
  }

  void resendOtp() {
    setState(() {
      _start = 180;
    });
    startTimer();
    // Call the resend OTP API here
    // You can use the emailController.text to get the email
    // Example:
    context.read<SigninCubit>().resendOtp(widget.emailController);
  }

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
                child: NewPassword(
                  email: widget.emailController,
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
            height: 700,
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
                      SizedBox(height: 50),
                      Center(
                        child: Text(
                          'Enter the OTP code',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      StreamBuilder<int>(
                        stream: _stream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: otpController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Enter OTP',
                              hintStyle: TextStyle(
                                color: Colors.blue[100],
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter OTP';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: _start == 0 ? resendOtp : null,
                          child: Text(
                            _start == 0
                                ? 'Resend OTP'
                                : 'Resend OTP (${_start ~/ 60}:${_start % 60})',
                            style: TextStyle(
                              fontSize: 14,
                              color: _start == 0 ? Colors.white : Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      LoginButton(
                        width: 390,
                        height: 100,
                        text: 'Submit',
                        color: Colors.white,
                        textColor: const Color.fromARGB(255, 0, 88, 161),
                        loading: false,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SigninCubit>().forgetPasswordOtp(
                                  otpController.text,
                                  widget.emailController,
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
