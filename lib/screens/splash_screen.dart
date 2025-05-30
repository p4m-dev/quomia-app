import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quomia/screens/main_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    var user = FirebaseAuth.instance.currentUser;

    // if (user != null) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    // } else {
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const PreLoginScreen()));
    // }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light.background,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.light.primary,
                  highlightColor: AppColors.light.secondary,
                  child: GradientText(
                    'Quomia',
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                    colors: [
                      AppColors.light.primary,
                      AppColors.light.secondary,
                      AppColors.light.tertiary
                    ],
                    gradientDirection: GradientDirection.ltr,
                    gradientType: GradientType.linear,
                  ),
                ),
                Text(
                  'WHERE TIME MATTERS',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: AppColors.light.primaryText,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Text(
              'v0.1.0',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                color: AppColors.light.primaryText.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
