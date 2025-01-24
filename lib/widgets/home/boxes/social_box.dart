import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/label_placeholder.dart';
import 'package:quomia/http/box_http.dart';
import 'package:quomia/models/box/box.dart';
import 'package:quomia/widgets/home/boxes/box.dart';
import 'package:quomia/widgets/home/boxes/box_placeholder.dart';

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
      debugPrint('Errore durante il caricamento dei timers: $e');
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
    return Column(
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
          height: 20.0,
        ),
        SizedBox(
            height: 400,
            child: FutureBuilder<List<Box>>(
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
                    return const Center(child: Text('No boxes found'));
                  }

                  final boxes = snapshot.data!;

                  return ListView.builder(
                      itemCount: boxes.length,
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
                })),
      ],
    );
  }
}
