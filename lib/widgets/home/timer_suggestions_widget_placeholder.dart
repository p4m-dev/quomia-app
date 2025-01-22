import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class TimerSuggestionsPlaceholderWidget extends StatelessWidget {
  const TimerSuggestionsPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _avatarPlaceholder(),
            const Gap(
              width: 8.0,
            ),
            _avatarPlaceholder(),
            const Gap(
              width: 8.0,
            ),
            _avatarPlaceholder(),
            const Gap(
              width: 8.0,
            ),
            _avatarPlaceholder(),
          ],
        ),
      ),
    );
  }

  Widget _avatarPlaceholder() {
    return Container(
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
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ],
          ),
        ));
  }
}
