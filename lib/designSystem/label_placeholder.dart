import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LabelPlaceholder extends StatelessWidget {
  const LabelPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
            width: 220,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.0))));
  }
}
