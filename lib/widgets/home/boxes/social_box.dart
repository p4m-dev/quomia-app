import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/label_placeholder.dart';
import 'package:quomia/http/box_http.dart';
import 'package:quomia/models/box/box.dart';
import 'package:quomia/widgets/home/boxes/box.dart';
import 'package:quomia/widgets/home/boxes/box_placeholder.dart';
import 'dart:developer' as developer;

class SocialBox extends StatefulWidget {
  const SocialBox({super.key});

  @override
  State<SocialBox> createState() => _SocialBoxState();
}

class _SocialBoxState extends State<SocialBox> {
  late Future<List<Box>> _socialBoxes;
  final HttpBoxService httpBoxService = HttpBoxService();
  bool _isLoading = true;

  Future<void> _loadSocialBoxes() async {
    try {
      _socialBoxes = httpBoxService.fetchSocialBoxes();
      await _socialBoxes;
    } catch (e) {
      developer.log('Error while loading timers: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSocialBoxes();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _isLoading
              ? const LabelPlaceholder()
              : const Label(
                  data: 'Per te',
                  fontSize: 24,
                ),
          const Gap(
            height: 10.0,
          ),
          FutureBuilder<List<Box>>(
              future: _socialBoxes,
              builder: (context, snapshot) {
                // Loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const BoxWidgetPlaceholder();
                }

                // Error state
                if (snapshot.hasError) {
                  return const BoxWidgetPlaceholder();
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const BoxWidgetPlaceholder();
                }

                final boxes = snapshot.data!;

                return ListView.builder(
                    itemCount: boxes.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BoxWidget(box: boxes[index]),
                          if (index < boxes.length - 1)
                            const Gap(
                              height: 16,
                            )
                        ],
                      );
                    });
              }),
        ],
      ),
    );
  }
}
