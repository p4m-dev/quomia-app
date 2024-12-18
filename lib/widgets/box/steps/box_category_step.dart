import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/models/box_helper.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/models/category.dart' as cat;
import 'package:quomia/widgets/box/card/box_card.dart';

class BoxCategoryStep extends StatefulWidget {
  final BoxHelper boxHelper;
  final String interactive = 'Interattivo';
  final String text = 'Testuale';

  const BoxCategoryStep({super.key, required this.boxHelper});

  @override
  State<BoxCategoryStep> createState() => _BoxCategoryStepState();
}

class _BoxCategoryStepState extends State<BoxCategoryStep> {
  @override
  void initState() {
    super.initState();
    widget.boxHelper.categoryNotifier.addListener(_onCategoryChanged);
  }

  @override
  void dispose() {
    widget.boxHelper.categoryNotifier.removeListener(_onCategoryChanged);
    super.dispose();
  }

  void _onCategoryChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(data: 'Categoria Box'),
            const Gap(
              height: 10.0,
            ),
            const Subtitle(data: 'Che categoria di Box desideri acquistare?'),
            const Gap(
              height: 10.0,
            ),
            BoxCard(
              title: widget.interactive,
              caption: 'Condividi un momento nel futuro con la persona cara.',
              imagePath: 'https://picsum.photos/seed/37/600',
              callback: () {
                setState(() {
                  widget.boxHelper.category = _convert(widget.interactive);
                });
              },
            ),
            const Gap(
              height: 10.0,
            ),
            BoxCard(
              title: widget.interactive,
              caption: 'Condividi un momento nel futuro con la persona cara.',
              imagePath: 'https://picsum.photos/seed/37/600',
              callback: () {
                setState(() {
                  widget.boxHelper.category = _convert(widget.interactive);
                });
              },
            ),
          ]),
    );
  }

  cat.Category _convert(String title) {
    cat.Category category = cat.Category.text;

    switch (title) {
      case 'text':
        category = cat.Category.text;
      case 'audio':
        category = cat.Category.audio;
      case 'image':
        category = cat.Category.image;
      case 'video':
        category = cat.Category.video;
    }

    return category;
  }
}
