import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String data;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const Label(
      {super.key,
      required this.data,
      this.fontSize,
      this.fontWeight,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(data,
        style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: fontSize ?? 16,
            fontWeight: fontWeight ?? FontWeight.w600,
            color: color));
  }
}
