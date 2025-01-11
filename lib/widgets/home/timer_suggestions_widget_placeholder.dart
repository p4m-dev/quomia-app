import 'package:flutter/material.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/utils/app_colors.dart';

class TimerSuggestionsPlaceholderWidget extends StatelessWidget {
  const TimerSuggestionsPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
      child: Container(
          width: 120,
          decoration: BoxDecoration(
              color: AppColors.light.primaryBackground,
              borderRadius: BorderRadius.circular(16.0)),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Label(
                  data: 'timer.username',
                  fontSize: 12,
                ),
                Label(
                  data: 'timer.username',
                  fontSize: 12,
                )
              ],
            ),
          )),
    );
  }
}
