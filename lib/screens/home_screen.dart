import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/screens/buy_box_screen.dart';
import 'package:quomia/screens/user_profile_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/common/custom_bottom_app_bar.dart';
import 'package:quomia/widgets/home/box.dart';
import 'package:quomia/widgets/home/suggestions.dart';

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
              //context.();
            }),
        title: Text('Quomia',
            style: TextStyle(
              fontFamily: 'DM Sans',
              color: AppColors.light.info,
              fontSize: 28,
            )),
        actions: [],
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BuyBoxScreen()));
        },
        tooltip: 'Cool FAB',
        shape: const CircleBorder(),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: const Alignment(0.0, 0.0),
              radius: 0.5,
              colors: [
                AppColors.light.tertiary,
                AppColors.light.primary,
              ],
            ),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.hourglass,
              color: AppColors.light.primaryText,
              size: 24,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(onProfilePressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserProfileScreen()));
      }),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(
                data: 'I miei suggerimenti',
                fontSize: 24,
              ),
              const TimerSuggestion(),
              const Label(
                data: 'Per te',
                fontSize: 24,
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  const Box(),
                  const Box(),
                  const Box(),
                  const Box(),
                  const Box()
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
