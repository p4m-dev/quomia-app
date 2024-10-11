import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PreloginScreen extends StatelessWidget {
  const PreloginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [Lottie.asset("assets/")],
      ),
    );
  }
}
