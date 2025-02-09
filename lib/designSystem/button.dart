import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final VoidCallback onPressed;

  const Button(
      {super.key,
      required this.backgroundColor,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 48),
            backgroundColor: backgroundColor,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26))),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ));
  }
}
