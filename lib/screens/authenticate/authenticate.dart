// import 'package:flutter/material.dart';
// import 'package:test_1/screens/authenticate/register.dart';
// import 'package:test_1/screens/authenticate/sign_in.dart';

// class Authenticate extends StatefulWidget {
//   const Authenticate({Key? key}) : super(key: key);

//   @override
//   State<Authenticate> createState() => _AuthenticateState();
// }

// class _AuthenticateState extends State<Authenticate> {
//   bool showSignIn = true;
//   void toggleView() {
//     //print(showSignIn.toString());
//     setState(() => showSignIn = !showSignIn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showSignIn) {
//       return const SignIn();
//     } else {
//       return Register(toggleView: toggleView);
//     }
//   }
// }
