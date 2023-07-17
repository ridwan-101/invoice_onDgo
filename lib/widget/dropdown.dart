// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyDropDownButton extends StatefulWidget {
  @override
  _MyDropDownButtonState createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  String? selectedCurrency; // Initial value for selectedCurrency is null

  List<String> currencies = ['NGN', 'USD', 'EUR', 'GBP'];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCurrency,
      items: [
        DropdownMenuItem<String>(
          value: null,
          child: const Text(
            'Select Currency',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ...currencies.map((String currency) {
          return DropdownMenuItem<String>(
            value: currency,
            child: Text(
              currency,
              style: TextStyle(color: Colors.black),
            ),
          );
        }),
      ],
      onChanged: (String? newValue) {
        setState(() {
          selectedCurrency = newValue;
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        prefixIcon: Icon(
          Icons.money,
          color: Color.fromARGB(255, 0, 88, 161),
          size: 30,
        ),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
