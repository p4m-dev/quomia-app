import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  Future<void> _launchWebXR() async {
    try {
      await launchUrl(
        Uri.parse("https://quomia.web.app"),
        customTabsOptions: const CustomTabsOptions(
          showTitle: false,
          instantAppsEnabled: true,
          urlBarHidingEnabled: true,
        ),
      );
    } catch (e) {
      debugPrint("Errore apertura WebXR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _launchWebXR,
      child: const Text("Apri esperienza AR"),
    );
  }
}
