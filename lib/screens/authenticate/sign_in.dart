import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_service.dart';
import '../constant.dart';
import '../home/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final Authentication auth = Authentication();
  String? email;
  String? password;
  String? errorValue;
  bool isShowError = false;

  void showError(bool value) {
    setState(() {
      isShowError = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 60),
                Container(
                  height: 50,
                  decoration: decoratedBorder,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        email = value;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: decoratedBorder,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none,
                      ),
                      obscureText: true,
                      onSaved: (value) {
                        password = value;
                      },
                    ),
                  ),
                ),
                if (errorValue != null && isShowError == true)
                  Text(
                    errorValue.toString(),
                    style: const TextStyle(color: Colors.red, fontSize: 15),
                  ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: elevatedButtonShape,
                    onPressed: () async {
                      _formKey.currentState?.save();
                      auth
                          .userSignIn(email.toString().trim(), password)
                          .then((value) {
                        if (value == "ok") {
                          showError(false);

                          Get.off(const Home());
                        } else {
                          errorValue = value;
                          showError(true);
                        }
                      });
                    },
                    child: Ink(
                      decoration: buttonDecoration,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: const Text(
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
}
