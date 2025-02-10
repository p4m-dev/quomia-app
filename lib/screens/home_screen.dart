import 'package:flutter/material.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/home/boxes/social_box.dart';
import 'package:quomia/widgets/home/timers/suggestions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: AppColors.light.background,
        appBar: AppBar(
          backgroundColor: AppColors.light.primaryBackground,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: AppColors.light.primaryText,
                size: 30,
              ),
              onPressed: () async {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }),
          title: Text('Quomia',
              style: TextStyle(
                fontFamily: 'DM Sans',
                color: AppColors.light.info,
                fontSize: 28,
              )),
          actions: const [],
          centerTitle: false,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  TimerSuggestion(),
                  SocialBox(),
                ],
              ),
            ),
          ),
        ));
  }
}
