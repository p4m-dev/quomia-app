import 'package:flutter/material.dart';
import 'package:quomia/theme/palette.dart';

class Subtitle extends StatelessWidget {
  final String data;
  const Subtitle({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(data,
        style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 16,
            color: AppColors.light.secondaryText));
  }
}
