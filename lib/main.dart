import 'package:flutter/material.dart';
import 'package:quomia/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quomia/screens/splash_screen.dart';
import 'package:quomia/theme/theme.dart';

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
      home: const SplashScreen(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
