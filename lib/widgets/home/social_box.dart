import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/http/box_http.dart';
import 'package:quomia/models/box/box.dart';
import 'package:quomia/widgets/home/box.dart';

class SocialBox extends StatefulWidget {
  const SocialBox({super.key});

  @override
  State<SocialBox> createState() => _SocialBoxState();
}

class _SocialBoxState extends State<SocialBox> {
  late Future<List<Box>> _socialBoxes;
  final HttpBoxService httpBoxService = HttpBoxService();

  @override
  void initState() {
    super.initState();
    _socialBoxes = httpBoxService.fetchSocialBoxes();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Label(
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
                    print("waiting...");
                  }

                  // Error state
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
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
