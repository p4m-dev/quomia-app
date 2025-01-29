import 'package:flutter/material.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/models/box/timer.dart';
import 'package:quomia/theme/palette.dart';

class TimerSuggestionsWidget extends StatelessWidget {
  final Timer timer;

  const TimerSuggestionsWidget({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
      child: InkWell(
          splashColor: Colors.grey,
          focusColor: Colors.grey,
          hoverColor: Colors.grey,
          highlightColor: Colors.grey,
          onTap: () {
            //context.pushNamed('TimerProfileScreen');
          },
          child: Container(
              width: 120,
              decoration: BoxDecoration(
                  color: AppColors.light.primaryBackground,
                  borderRadius: BorderRadius.circular(16.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(timer.avatar),
                      minRadius: 30.0,
                      maxRadius: 30.0,
                    ),
                    Label(
                      data: timer.username,
                      fontSize: 12,
                    )
                  ],
                ),
              ))),
    );
  }
}
