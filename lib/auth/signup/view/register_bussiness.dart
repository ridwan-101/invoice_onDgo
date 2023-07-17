// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_ondgo/auth/signin/logic/cubit/signin_cubit.dart';
import 'package:invoice_ondgo/auth/signin/view/login_page.dart';
import 'package:invoice_ondgo/auth/signup/logic/cubit/business_registration_cubit.dart';
import 'package:invoice_ondgo/widget/dropdown.dart';
import 'package:invoice_ondgo/widget/buttons.dart';

class RegisterBussinessPage extends StatefulWidget {
  final String userId;
  const RegisterBussinessPage({super.key, required this.userId});
  @override
  State<RegisterBussinessPage> createState() => _RegisterBussinessPageState();
}

class _RegisterBussinessPageState extends State<RegisterBussinessPage> {
  @override
  void initState() {
    print(widget.userId);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController businessNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BusinessRegistrationCubit, BusinessRegistrationState>(
      listener: (context, state) {
        state.success
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => SigninCubit(context),
                    child: Loginpage(
                      title: '',
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
            height: MediaQuery.of(context).size.height,
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
                        height: 80,
                      ),
                      Center(
                        child: Text(
                          'Register your business',
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
                        'Please register your business to get started.',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: businessNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Business name',
                          hintStyle: TextStyle(
                            color: Colors.blue[100],
                          ),
                          prefixIcon: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                              'images/Customer.png',
                              width: 30,
                              height: 30,
                              color: const Color(0xFF01497C),
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                            color: Colors.blue[100],
                          ),
                          prefixIcon: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                              'images/Smartphone.png',
                              width: 30,
                              height: 30,
                              color: const Color(0xFF01497C),
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Location',
                          hintStyle: TextStyle(
                            color: Colors.blue[100],
                          ),
                          prefixIcon: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                              'images/WorldwideLocation.png',
                              width: 30,
                              height: 30,
                              color: const Color(0xFF01497C),
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: stateController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'State',
                          hintStyle: TextStyle(
                            color: Colors.blue[100],
                          ),
                          prefixIcon: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                              'images/WorldwideLocation.png',
                              width: 30,
                              height: 30,
                              color: const Color(0xFF01497C),
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: accountNameController,
                        decoration: InputDecoration(
                          hintText: 'Account Name',
                          hintStyle: TextStyle(
                            color: Colors.blue[100],
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                              'images/Merchant_Account.png',
                              width: 30,
                              height: 30,
                              color: const Color(0xFF01497C),
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: bankController,
                        decoration: InputDecoration(
                          hintText: 'Bank',
                          hintStyle: TextStyle(
                            color: Colors.blue[100],
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                              'images/Bank_Building.png',
                              width: 30,
                              height: 30,
                              color: const Color(0xFF01497C),
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: accountNumberController,
                        decoration: InputDecoration(
                          hintText: 'Account Number',
                          hintStyle: TextStyle(
                            color: Colors.blue[100],
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                              'images/account_num.png',
                              width: 30,
                              height: 30,
                              color: const Color(0xFF01497C),
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyDropDownButton(),
                      SizedBox(
                        height: 20,
                      ),
                      BusinessRegButtton(
                        color: Colors.white,
                        height: 100,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<BusinessRegistrationCubit>()
                                .registration(
                                  businessNameController.text,
                                  locationController.text,
                                  accountNameController.text,
                                  bankController.text,
                                  accountNumberController.text,
                                  phoneNumberController.text,
                                  stateController.text,
                                  context
                                      .read<BusinessRegistrationCubit>()
                                      .currency,
                                  widget.userId,

                                  // userId
                                );
                          }
                        },
                        text: 'Get Started',
                        textColor: const Color(0xFF01497C),
                        width: 2000,
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
