import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Lottie.asset(
            'assets/animations/hourglass.json',
            repeat: true,
            animate: true,
          ),
        ),
      ),
    );
  }
}
