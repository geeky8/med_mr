import 'package:flutter/material.dart';
import 'package:medrpha_trial/auth/screens/login_screen.dart';
import 'package:medrpha_trial/bottom_navigation/screens/landing_screen.dart';
import 'package:medrpha_trial/users/utils/success_failure_verification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
