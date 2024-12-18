import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double? height;
  final double? width;

  const Gap({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
