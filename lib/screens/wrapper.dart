import 'package:flutter/material.dart';
import 'package:test_1/services/auth_service.dart';
import 'authenticate/sign_in.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Authentication auth = Authentication();

    // return either the Home or Authenticate widget
    if (auth.auth.currentUser?.uid == null) {
      return const SignIn();
    } else {
      return const Home();
    }
  }
}
