// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_ondgo/auth/signin/logic/cubit/signin_cubit.dart';
import 'package:invoice_ondgo/widget/password.dart';
import 'package:invoice_ondgo/auth/signin/view/login_page.dart';

import '../../../widget/loginbutton.dart';

class NewPassword extends StatefulWidget {
  final String email;
  NewPassword({required this.email});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(listener: (context, state) {
      if (state.success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => SigninCubit(context),
              child: Loginpage(title: ''),
            ),
          ),
        );
      }
    }, builder: (context, state) {
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
                    Text(
                      'Hi there',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Welcome back',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Text(
                        'Enter New Password',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Please enter a new password',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PasswordTextField(controller: passwordController),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Re-enter password',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autofocus: false,
                      controller: confirmPasswordController,
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        confirmPasswordController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true, // Enable fill color
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Color(0x8098F980), // Set the border color here
                          ),
                        ),
                        prefixIcon: Icon(Icons.lock_outline_rounded,
                            color: Colors.blue[100]),
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    LoginButton(
                      width: 390,
                      height: 200,
                      text: 'Confirm Password',
                      loading: false,
                      color: Colors.white,
                      textColor: Color.fromARGB(255, 0, 88, 161),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SigninCubit>().updatePassword(
                                widget.email,
                                passwordController.text,
                                confirmPasswordController.text,
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
    });
  }
}
