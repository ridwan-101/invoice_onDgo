// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_ondgo/home/views/dashboard.dart';
import 'package:invoice_ondgo/invoices/view/invoice.dart';
import 'package:invoice_ondgo/item/item_list.dart';
import 'package:invoice_ondgo/item/logic/item_cubit.dart';
import 'package:invoice_ondgo/home/views/profile.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    BlocProvider(
      create: (context) => ItemCubit(context),
      child: ItemPage(),
    ),
    InvoiceCreation(),
    ProfilePage(),
  ];

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      // If not on the home screen, navigate to the home screen
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    } else {
      // If on the home screen, show the exit confirmation dialog
      bool exitConfirmed = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Are you sure you want to exit the app?'),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                    child: Text('Exit'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ) ??
          false;

      if (exitConfirmed) {
        // If exit confirmed, quit the app silently
        return true;
      } else {
        return false;
      }
    }
  }

  void _onTabSelected(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onTabSelected,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF01497C),
              icon: Image.asset('images/home.png'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF01497C),
              icon: Image.asset('images/invoice-nav.png'),
              label: 'Item',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF01497C),
              icon: Image.asset('images/item-nav.png'),
              label: 'Invoice',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF01497C),
              icon: Image.asset('images/setting-2.png'),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
