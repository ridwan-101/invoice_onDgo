// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:invoice_ondgo/auth/signin/logic/cubit/signin_cubit.dart';
// import 'package:invoice_ondgo/home/homepage.dart';
// import 'package:invoice_ondgo/profile/view/profile.dart';
// import 'package:invoice_ondgo/auth/signin/view/login_page.dart';

// class DrawerPage extends StatelessWidget {
//   const DrawerPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: [
//           Container(
//             color: Color(0xFF01497C),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 80,
//                     backgroundImage: AssetImage(
//                       'images/Profilepicture.png',
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text('Sweet Tooth',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white)),
//                   SizedBox(height: 10),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => ProfilePage()),
//                       );
//                     },
//                     child: Text('View Profile',
//                         style: TextStyle(fontSize: 20, color: Colors.white)),
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomeScreen()),
//                         );
//                       },
//                       child: Row(children: [
//                         Image.asset('images/menu.png'),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text('DashBoard',
//                             style: TextStyle(
//                                 color: Color(0xFF01497C), fontSize: 16))
//                       ]),
//                     ),
//                     SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomeScreen()),
//                         );
//                       },
//                       child: Row(children: [
//                         Image.asset('images/menu.png'),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text('Templates',
//                             style: TextStyle(
//                                 color: Color(0xFF01497C), fontSize: 16))
//                       ]),
//                     ),
//                     SizedBox(height: 20),
//                     Row(children: [
//                       Image.asset('images/security-safe.png'),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text('Terms & Conditions',
//                           style:
//                               TextStyle(color: Color(0xFF01497C), fontSize: 16))
//                     ]),
//                     SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomeScreen()),
//                         );
//                       },
//                       child: Row(children: [
//                         Image.asset('images/Feedback.png'),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text('Feedback',
//                             style: TextStyle(
//                                 color: Color(0xFF01497C), fontSize: 16))
//                       ]),
//                     ),
//                     SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomeScreen()),
//                         );
//                       },
//                       child: Row(children: [
//                         Image.asset('images/contactus.png'),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text('Contact Us',
//                             style: TextStyle(
//                                 color: Color(0xFF01497C), fontSize: 16))
//                       ]),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//                 SizedBox(
//                   width: 100,
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => BlocProvider(
//                                   create: (context) => SigninCubit(context),
//                                   child: const Login_page(
//                                     title: '',
//                                   ),
//                                 )),
//                       );
//                     },
//                     child: Text('Logout',
//                         style:
//                             TextStyle(color: Color(0xFF01497C), fontSize: 20)))
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
