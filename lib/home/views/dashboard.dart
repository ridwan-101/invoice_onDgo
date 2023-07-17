// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:invoice_ondgo/home/views/profile.dart';
import 'package:invoice_ondgo/invoices/view/invoice.dart';
import 'package:invoice_ondgo/item/item_list.dart';
import 'package:invoice_ondgo/item/logic/item_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<String> fetchUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final busiId = prefs.getString('businessId');
      final token = prefs.getString('tokenn');
      print(busiId);
      final headers = {
        'Content-type': 'application/json; charset=utf-8',
        'Authorization': "Bearer $token",
      };

      final response = await http.get(
        Uri.parse(
            'https://invoice-generator-walure-tap.azurewebsites.net/api/Business/Get-Business/$busiId'),
        headers: headers,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          username = data['payload']['businessName'];
        });
        return data['payload']['businessName'];
      } else {
        throw Exception("Failed");
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception("Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Color(0xFF01497C),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF01497C),
                ),
                width: MediaQuery.of(context).size.width,
                height: 130.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, $username 👋',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => ItemCubit(context),
                              child: ItemPage(),
                            ),
                          ),
                        );
                      },
                      child: TextCard(
                          imagePath: 'images/briefcase.png', text: 'Items')),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvoiceCreation()),
                        );
                      },
                      child: TextCard(
                          imagePath: 'images/file-text.png', text: 'Invoice')),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ItemPage()),
                      // );
                    },
                    child: TextCard(
                        imagePath: 'images/invoicehistory.png',
                        text: 'Invoice History'),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                      child: TextCard(
                          imagePath: 'images/settings.png', text: 'settings')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextCard extends StatelessWidget {
  final String imagePath;
  final String text;

  const TextCard({
    super.key,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFF01497C),
      ),
      width: 180,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
