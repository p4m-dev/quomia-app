import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quomia/screens/home_screen.dart';
import 'package:quomia/screens/prelogin_screen.dart';
import 'package:quomia/utils/app_colors.dart';

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

    if (user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PreLoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light.background,
      body: Center(
          child: Image.asset(
        'assets/images/quomia_logo.png',
        width: 150,
        height: 150,
      )),
    );
  }
}
