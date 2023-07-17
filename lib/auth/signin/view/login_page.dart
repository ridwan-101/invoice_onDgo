// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:invoice_ondgo/auth/signup/logic/cubit/business_registration_cubit.dart';

import 'package:invoice_ondgo/auth/signup/view/sign_up_page.dart';
import 'package:invoice_ondgo/home/views/home.dart';

import '../../../widget/checkbox.dart';
import '../../../widget/email.dart';
import '../../../widget/loginbutton.dart';
import '../../../widget/password.dart';
import '../logic/cubit/signin_cubit.dart';
import 'forgot_password.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key, required String title}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formKey = GlobalKey<FormState>(); // Define form key here

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        state.success
            ? Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              )
            : null;
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 40),
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
                            'Log into your account',
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
                        // Text(
                        //   'Please select a method to log in:',
                        //   style: TextStyle(fontSize: 14, color: Colors.white),
                        // ),
                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        EmailTextField(controller: emailController),
                        SizedBox(
                          height: 20,
                        ),
                        PasswordTextField(controller: passwordController),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClickableCheckbox(
                                  initialValue: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) =>
                                                SigninCubit(context),
                                            child: ForgetPassword(),
                                          )),
                                );
                              },
                              child: Text(
                                'Forget Password?',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        LoginButton(
                          width: 390,
                          height: 100,
                          text: 'Login',
                          color: Colors.white,
                          textColor: Color.fromARGB(255, 0, 88, 161),
                          loading: state.loading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SigninCubit>().login(
                                  emailController.text,
                                  passwordController.text);
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dont have account?  ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) =>
                                                BusinessRegistrationCubit(
                                                    context),
                                            child: SignupPage(),
                                          )),
                                );
                              },
                              child: Text(
                                'Create an account',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}
