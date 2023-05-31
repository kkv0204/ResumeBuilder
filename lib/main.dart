import 'package:resume_builder/homepagescreen/logout.dart';
import 'package:resume_builder/login.dart';
import 'package:resume_builder/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Resume Builder',
    theme: ThemeData(),
    home: const SplashScreen(),
    debugShowCheckedModeBanner: false,
    );
  }
}
