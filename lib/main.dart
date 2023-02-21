import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './screens/wrapper.dart';
import 'package:provider/provider.dart';
import './services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.green[400],
            ),
      ),
      home: const Wrapper(),
    );
  }
}
