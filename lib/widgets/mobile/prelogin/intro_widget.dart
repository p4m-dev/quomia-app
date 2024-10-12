import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 500,
      child: Lottie.asset('assets/animations/intro.json'),
    );
  }
}
