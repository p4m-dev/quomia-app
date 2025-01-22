import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quomia/screens/home_screen.dart';
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
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: AppColors.light.primary,
                highlightColor: AppColors.light.secondary,
                child: GradientText(
                  'Quomia',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: AppColors.light.primary,
                    fontSize: 40,
                    letterSpacing: 0.0,
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
              Text('WHERE TIME MATTERS',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: AppColors.light.primaryText,
                      letterSpacing: 0.0)),
            ],
          ),
        ));
  }
}
