import 'package:flutter/material.dart';

class TextContent extends StatelessWidget {
  final String data;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int maxLines;
  final TextOverflow overflow;

  const TextContent(
      {super.key,
      required this.data,
      this.fontSize,
      this.fontWeight,
      this.color,
      required this.maxLines,
      required this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(data,
        overflow: overflow,
        maxLines: maxLines,
        style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: fontSize ?? 16,
            fontWeight: fontWeight ?? FontWeight.w600,
            color: color));
  }
}
