import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String data;

  const CustomTitle({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(data,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600));
  }
}
