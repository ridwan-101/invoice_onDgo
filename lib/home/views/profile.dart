// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:invoice_ondgo/home/views/edit_business_page.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    fetchPhoneNumber();
  }

  Future<String> fetchPhoneNumber() async {
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
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          username = data['payload']['businessName'];
          phoneNumber = data['payload']['phoneNumber'];
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
        elevation: 0,
        backgroundColor: const Color(0xFF01497C),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFF01497C),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/Profilepicture.png'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '$username',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      // email,
                      '$phoneNumber',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset('images/profileline.png'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditBussinessPage(
                                  businessId: '',
                                )),
                      );
                    },
                    child: Row(
                      children: [
                        Image.asset('images/Edit.png'),
                        const SizedBox(width: 10),
                        const Text(
                          'Edit Business Profile',
                          style: TextStyle(
                            color: Color(0xFF01497C),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => ProfilePage()),
                  //     );
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Image.asset('images/User.png'),
                  //       const SizedBox(width: 10),
                  //       const Text(
                  //         'Add/Switch Organization',
                  //         style: TextStyle(
                  //           color: Color(0xFF01497C),
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => ProfilePage()),
                  //     );
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Image.asset('images/Banknotes.png'),
                  //       const SizedBox(width: 10),
                  //       const Text(
                  //         'Currency',
                  //         style: TextStyle(
                  //           color: Color(0xFF01497C),
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: Row(
                      children: [
                        Image.asset('images/Lock.png'),
                        const SizedBox(width: 10),
                        const Text(
                          'Privacy and Security',
                          style: TextStyle(
                            color: Color(0xFF01497C),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset('images/Payment_Check.png'),
                          const SizedBox(width: 10),
                          const Text(
                            'Log Out',
                            style: TextStyle(
                              color: Color(0xFF01497C),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
