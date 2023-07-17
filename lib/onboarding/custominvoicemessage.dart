import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_ondgo/auth/signin/logic/cubit/signin_cubit.dart';
import 'package:invoice_ondgo/auth/signin/view/login_page.dart';
import 'package:invoice_ondgo/onboarding/paymenttrackingmessage.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/onthegobg.png"),
            fit: BoxFit.none,
          ),
          color:
              Color(0xFF01497C), // Replace with your desired background color
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
              image: AssetImage("images/phone1.png"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Design and personalize your invoices \n to reflect your brand's identity",
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
                    builder: (context) => const FinalMessage(),
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
