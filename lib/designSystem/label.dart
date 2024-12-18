import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String data;

  const Label({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(data,
        style: const TextStyle(
            fontFamily: 'DM Sans', fontSize: 16, fontWeight: FontWeight.w600));
  }
}
