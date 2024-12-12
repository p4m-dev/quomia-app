import 'package:flutter/material.dart';
import 'package:quomia/utils/app_colors.dart';

class StepProgressView extends StatelessWidget {
  final double width;
  final List<String> titles;
  final int currentStep;
  final Color _activeColor = AppColors.light.secondary;
  final Color _inactiveColor = AppColors.light.background;
  final double lineWidth = 3.0;

  StepProgressView(
      {super.key,
      required this.titles,
      required this.width,
      required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                color: AppColors.light.primaryBackground),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: _iconViews(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _titleViews(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    titles.asMap().forEach((i, icon) {
      var circleColor =
          (i == 0 || currentStep > i + 1) ? _activeColor : _inactiveColor;
      var lineColor = currentStep > i + 1 ? _activeColor : _inactiveColor;
      var iconColor =
          (i == 0 || currentStep > i + 1) ? _activeColor : _inactiveColor;

      list.add(
        Container(
          width: 20.0,
          height: 20.0,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(22.0)),
            border: Border.all(
              color: circleColor,
              width: 2.0,
            ),
          ),
          child: Icon(
            Icons.circle,
            color: iconColor,
            size: 12.0,
          ),
        ),
      );

      if (i != titles.length - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    });

    return list;
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    titles.asMap().forEach((i, text) {
      list.add(Text(text,
          style: TextStyle(
              color: AppColors.light.primaryText,
              fontFamily: 'DM Sans',
              fontSize: 12)));
    });
    return list;
  }
}
