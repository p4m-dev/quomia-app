import 'package:flutter/material.dart';

class TimeUtils {
  static Future<void> selectTime(
      BuildContext context, TextEditingController controller,
      {required ColorScheme colorScheme,
      required Color dialogBackgroundColor}) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      confirmText: 'Conferma',
      cancelText: 'Annulla',
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: colorScheme,
            dialogBackgroundColor: dialogBackgroundColor,
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      controller.text = selectedTime.format(context);
    }
  }
}
