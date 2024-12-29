import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/box_type.dart';
import 'package:quomia/widgets/box/card/box_card.dart';

class BoxTypeStep extends StatefulWidget {
  final BoxHelper boxHelper;
  final ValueChanged<int> onStepChanged;
  final ValueChanged<BoxType?> onBoxTypeChanged;
  final int currentStep;

  final String messageInABottle = 'Message in a bottle';
  final String future = 'Future';
  final String rewind = 'Rewind';

  const BoxTypeStep(
      {super.key,
      required this.boxHelper,
      required this.onStepChanged,
      required this.onBoxTypeChanged,
      required this.currentStep});

  @override
  State<BoxTypeStep> createState() => _BoxTypeStepState();
}

class _BoxTypeStepState extends State<BoxTypeStep> {
  @override
  void initState() {
    super.initState();
    widget.boxHelper.boxTypeNotifier.addListener(_onBoxTypeChanged);
  }

  @override
  void dispose() {
    widget.boxHelper.boxTypeNotifier.removeListener(_onBoxTypeChanged);
    super.dispose();
  }

  void _onBoxTypeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTitle(data: 'Tipologia Box'),
          const Gap(
            height: 5.0,
          ),
          const Subtitle(data: 'Scegli il box che più ti si addice'),
          const Gap(
            height: 10.0,
          ),
          BoxCard(
            title: widget.future,
            caption: 'Condividi un momento nel futuro con la persona cara.',
            imagePath: 'https://picsum.photos/seed/37/600',
            callback: () {
              setState(() {
                widget.boxHelper.boxType = _convert(widget.future);
                widget.onStepChanged(widget.currentStep + 1);

                if (widget.boxHelper.boxType != null) {
                  widget.onBoxTypeChanged(widget.boxHelper.boxType);
                }
              });
            },
          ),
          const Gap(
            height: 10.0,
          ),
          BoxCard(
              title: widget.rewind,
              caption: 'Condividi un momento del passato con la persona cara.',
              imagePath: 'https://picsum.photos/seed/37/600',
              callback: () {
                setState(() {
                  widget.boxHelper.boxType = _convert(widget.rewind);
                  widget.onStepChanged(widget.currentStep + 1);

                  if (widget.boxHelper.boxType != null) {
                    widget.onBoxTypeChanged(widget.boxHelper.boxType);
                  }
                });
              }),
          const Gap(
            height: 10.0,
          ),
          BoxCard(
              title: widget.messageInABottle,
              caption: 'Rendi virale il tuo box.',
              imagePath: 'https://picsum.photos/seed/37/600',
              callback: () {
                setState(() {
                  widget.boxHelper.boxType = _convert(widget.messageInABottle);
                  widget.onStepChanged(widget.currentStep + 1);

                  if (widget.boxHelper.boxType != null) {
                    widget.onBoxTypeChanged(widget.boxHelper.boxType);
                  }
                });
              })
        ],
      ),
    );
  }

  BoxType? _convert(String title) {
    BoxType? boxType;

    switch (title.toLowerCase()) {
      case 'message in a bottle':
        boxType = BoxType.messageInABottle;
      case 'future':
        boxType = BoxType.future;
      case 'rewind':
        boxType = BoxType.rewind;
    }

    return boxType;
  }
}
