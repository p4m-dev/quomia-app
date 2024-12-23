import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String data;
  final double? fontSize;

  const Label({super.key, required this.data, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(data,
        style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: fontSize ?? 16,
            fontWeight: FontWeight.w600));
  }
}
