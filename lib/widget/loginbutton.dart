// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final double width;
  final double height;
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  LoginButton({
    required this.width,
    required this.text,
    required this.height,
    required this.color,
    required this.textColor,
    required this.onPressed,
    required bool loading,
  });

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool loading = false;

  void _startLoading() {
    setState(() {
      loading = true;
    });
    // Simulating an asynchronous operation
    Future.delayed(Duration(seconds: 20), () {
      _stopLoading();
    });
  }

  void _stopLoading() {
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: ElevatedButton(
        onPressed: loading
            ? null
            : () {
                _startLoading();
                widget.onPressed();
              },
        style: ElevatedButton.styleFrom(
          foregroundColor: widget.textColor,
          backgroundColor: widget.color,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: loading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                widget.text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
