import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final double? height;
  final double? width;

  const Separator({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
