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
  final ValueChanged<int> onStepChanged;
  final int currentStep;

  final String interactive = 'Interattivo';
  final String text = 'Testuale';

  const BoxCategoryStep(
      {super.key,
      required this.boxHelper,
      required this.onStepChanged,
      required this.currentStep});

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
              caption:
                  'Crea un box interattivo, puoi aggiungere un video, un immagine o registrare un momento vocale',
              imagePath: 'https://picsum.photos/seed/37/600',
              callback: () {
                setState(() {
                  widget.boxHelper.category = _convert(widget.interactive);
                  widget.onStepChanged(widget.currentStep + 1);
                });
              },
            ),
            const Gap(
              height: 10.0,
            ),
            BoxCard(
              title: widget.text,
              caption: 'Riassapora il concetto di ',
              imagePath: 'https://picsum.photos/seed/37/600',
              callback: () {
                setState(() {
                  widget.boxHelper.category = _convert(widget.interactive);
                  widget.onStepChanged(widget.currentStep + 1);
                });
              },
            ),
          ]),
    );
  }

  cat.Category _convert(String title) {
    cat.Category category = cat.Category.text;

    switch (title) {
      case 'interactive':
        category = cat.Category.interactive;
      case 'text':
        category = cat.Category.text;
    }

    return category;
  }
}
