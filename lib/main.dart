import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:quomia/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quomia/screens/splash_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/utils/route_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Map
  //String ACCESS_TOKEN = const String.fromEnvironment("ACCESS_TOKEN");
  MapboxOptions.setAccessToken(
      "pk.eyJ1IjoiemFubmE5MjciLCJhIjoiY2toOTAxNXliMHBubDJ4bzh0Y2trNXRoOSJ9.UvaTov5Rw2_ZGJejF91lcg");

  // Initialize Firebase
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
      navigatorObservers: [routeObserver],
      theme: ThemeData(
          fontFamily: 'DM Sans', primaryColor: AppColors.light.primary),
      home: const SplashScreen(),
    );
  }
}
