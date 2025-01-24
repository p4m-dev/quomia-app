import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AvatarPlaceholder extends StatelessWidget {
  const AvatarPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: CircleAvatar(
        minRadius: 30.0,
        maxRadius: 30.0,
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}
