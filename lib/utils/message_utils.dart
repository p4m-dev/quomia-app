import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MessageUtils {
  static void showToast(
      String message, Color backgroundColor, Color textColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}
