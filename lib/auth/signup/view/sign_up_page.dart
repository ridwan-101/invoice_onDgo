// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_ondgo/auth/signin/logic/cubit/signin_cubit.dart';
import 'package:invoice_ondgo/auth/signin/view/login_page.dart';
import 'package:invoice_ondgo/auth/signup/logic/cubit/business_registration_cubit.dart';
import 'package:invoice_ondgo/auth/signup/view/registration_otp.dart';
import 'package:invoice_ondgo/widget/email.dart';
import 'package:invoice_ondgo/widget/loginbutton.dart';
import 'package:invoice_ondgo/widget/password.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BusinessRegistrationCubit, BusinessRegistrationState>(
      listener: (context, state) {
        // TODO: implement listener
        state.success
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => BusinessRegistrationCubit(context),
                    child: RegistrationOTPScreen(
                      emailController: emailController.text,
                    ),
                  ),
                ),
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
                // fit: BoxFit.cover,
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
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 40),
                              Text(
                                'Hi there',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 40),
                              Text(
                                'Create new account',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Center(
                        //   child: Text(
                        //     'Please select a method to log in:',
                        //     style: TextStyle(fontSize: 14, color: Colors.white),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       decoration: BoxDecoration(
                        //           color: Colors.grey[300],
                        //           borderRadius: BorderRadius.circular(10)),
                        //       child: Padding(
                        //         padding: EdgeInsets.all(8),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Image.asset(
                        //               'images/Google__G__Logo 1.png',
                        //               fit: BoxFit.cover,
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 20,
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //           color: Colors.grey[300],
                        //           borderRadius: BorderRadius.circular(10)),
                        //       child: Padding(
                        //         padding: EdgeInsets.all(8),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Image.asset(
                        //               'images/facebook.png',
                        //               fit: BoxFit.cover,
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Image.asset('images/Line 2.png'),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       'or signup with mail',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Image.asset('images/Line 2.png'),
                        //   ],
                        // ),
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
                                color: Color(
                                    0x8098F980), // Set the border color here
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.shield_outlined,
                              color: Colors.blue[100],
                              size: 30,
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.blue[100],
                            ),
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Please note that your password must meet the following requirements:',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '* It should contain at least one digit, one lowercase letter, one uppercase letter, be alphanumeric (a combination of letters and numbers), include one unique character, and be at least eight characters long.',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(
                          height: 50,
                        ),
                        LoginButton(
                          width: 390,
                          height: 100,
                          text: 'Create Account',
                          color: Colors.white,
                          loading: false,
                          textColor: Color.fromARGB(255, 0, 88, 161),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<BusinessRegistrationCubit>().signup(
                                  emailController.text.toString(),
                                  passwordController.text.toString(),
                                  confirmPasswordController.toString());
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?  ',
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
                                      create: (context) => SigninCubit(context),
                                      child: const Loginpage(
                                        title: '',
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Log in',
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
