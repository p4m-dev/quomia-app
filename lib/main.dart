import 'package:flutter/material.dart';
import 'package:quomia/firebase_options.dart';
import 'package:quomia/screens/buy_box_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quomia/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'DM Sans', primaryColor: AppColors.light.primary),
      home: const BuyBoxScreen(),
    );
  }
}
