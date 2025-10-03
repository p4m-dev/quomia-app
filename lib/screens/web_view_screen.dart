import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebXRScreenState();
}

class _WebXRScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    _openWebXR();
  }

  Future<void> _openWebXR() async {
    try {
      await launchUrl(
        Uri.parse("https://quomia.web.app"),
        customTabsOptions: const CustomTabsOptions(
          showTitle: false,
          urlBarHidingEnabled: true,
          instantAppsEnabled: true,
        ),
        safariVCOptions: const SafariViewControllerOptions(
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
          preferredBarTintColor: Colors.black,
          preferredControlTintColor: Colors.white,
        ),
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      debugPrint("Errore apertura WebXR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black, // splash nero
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
