import 'package:flutter/material.dart';
import 'package:text_style/view/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
    return  Scaffold(
      body: Center(child: Image.asset('assets/Logo.png'),),
    );
  }
}