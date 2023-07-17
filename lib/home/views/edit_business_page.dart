// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:invoice_ondgo/home/views/profile.dart';
import 'package:invoice_ondgo/widget/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditBussinessPage extends StatefulWidget {
  final String businessId;

  const EditBussinessPage({
    Key? key,
    required this.businessId,
  }) : super(key: key);

  @override
  State<EditBussinessPage> createState() => _EditBussinessPageState();
}

class _EditBussinessPageState extends State<EditBussinessPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController businessNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBusinessDetails();
  }

  Future<void> fetchBusinessDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final busiId = prefs.getString('businessId');
      final token = prefs.getString('tokenn');
      final headers = {
        'Content-type': 'application/json; charset=utf-8',
        'Authorization': "Bearer $token",
      };

      final response = await http.get(
        Uri.parse(
            'https://invoice-generator-walure-tap.azurewebsites.net/api/Business/Get-Business/$busiId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          businessNameController.text = data['payload']['businessName'];
          phoneNumberController.text = data['payload']['phoneNumber'];
          locationController.text = data['payload']['businessLocation'];
          stateController.text = data['payload']['state'];
          accountNameController.text = data['payload']['accountName'];
          bankController.text = data['payload']['bank'];
          accountNumberController.text = data['payload']['accountNumber'];
        });
      } else {
        print(
            'Failed to fetch business details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> updateBusinessProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final busiId = prefs.getString('businessId');
      final token = prefs.getString('tokenn');
      final url =
          'https://invoice-generator-walure-tap.azurewebsites.net/api/Business/EditBusinessProfile/$busiId';

      final headers = {
        'Content-type': 'application/json; charset=utf-8',
        'Authorization': "Bearer $token",
      };
      print(token);
      final body = jsonEncode({
        'id': busiId,
        'businessName': businessNameController.text,
        'phoneNumber': phoneNumberController.text,
        'businessLocation': locationController.text,
        'state': stateController.text,
        'accountName': accountNameController.text,
        'bank': bankController.text,
        'accountNumber': accountNumberController.text,
        "currency": 0
      });

      final response =
          await http.put(Uri.parse(url), headers: headers, body: body);
      print(body);
      if (response.statusCode == 200) {
        print('Business profile updated successfully.');
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Business profile updated successfully'),
            duration: Duration(seconds: 2),
          ),
        );
        // Handle success case
      } else {
        print(
            'Failed to update business profile. Status code: ${response.statusCode}');
        // Handle failure case
      }
    } catch (e) {
      print('Exception: $e');
      // Handle exception case
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 79, 141),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 2, 79, 141),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Edit your business',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
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
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
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
                          'images/WorldwideLocation.png',
                          width: 30,
                          height: 30,
                          color: const Color(0xFF01497C),
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
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
                          'images/WorldwideLocation.png',
                          width: 30,
                          height: 30,
                          color: const Color(0xFF01497C),
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
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
                          'images/WorldwideLocation.png',
                          width: 30,
                          height: 30,
                          color: const Color(0xFF01497C),
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  BusinessRegButtton(
                    color: const Color(0xFF01497C),
                    height: 100,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        updateBusinessProfile();
                      }
                    },
                    text: 'Save',
                    textColor: Colors.white,
                    width: 2000,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
