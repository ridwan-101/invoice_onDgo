import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_ondgo/auth/signin/logic/cubit/signin_cubit.dart';
import 'package:invoice_ondgo/auth/signin/view/login_page.dart';
import 'package:invoice_ondgo/onboarding/login_signupmessage.dart';

class FinalMessage extends StatefulWidget {
  const FinalMessage({Key? key}) : super(key: key);

  @override
  State<FinalMessage> createState() => _FinalMessageState();
}

class _FinalMessageState extends State<FinalMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/onthegobg.png"),
            fit: BoxFit.none,
          ),
          color: Color(0xFF01497C),
        ),
        child: Column(
          children: [
            const SizedBox(height: 80),
            InkWell(
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SizedBox(),
                    Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            const Image(
              image: AssetImage("images/newperson3.png"),
            ),
            const SizedBox(height: 20),
            const Text(
              " Get real-time updates on invoice statuses, \nincluding pending, paid, and overdue payments",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeePage(),
                  ),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height *
                    0.06, // 20% of the screen height
                width: MediaQuery.of(context).size.width *
                    0.9, // 80% of the screen width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Color(0xFF01497C),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
