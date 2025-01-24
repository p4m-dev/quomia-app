import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ButtonPlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ButtonPlaceholder(
      {super.key,
      required this.width,
      required this.height,
      required this.radius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.0))));
  }
}
