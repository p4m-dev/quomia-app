import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(0),
        width: 200,
        height: 300,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
        ));
  }
}
