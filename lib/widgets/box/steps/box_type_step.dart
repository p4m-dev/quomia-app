import 'package:flutter/material.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/models/box_helper.dart';
import 'package:quomia/models/box_type.dart';
import 'package:quomia/utils/app_colors.dart';

class BoxTypeStep extends StatefulWidget {
  final BoxHelper boxHelper;
  final String messageInABottle = 'Message in a bottle';
  final String future = 'Future';
  final String rewind = 'Rewind';

  const BoxTypeStep({super.key, required this.boxHelper});

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
          const SizedBox(
            height: 5.0,
          ),
          const Subtitle(data: 'Scegli il box che più ti si addice'),
          const SizedBox(
            height: 10.0,
          ),
          _boxTypeCard(
              widget.future,
              'Condividi un momento nel futuro con la persona cara.',
              'https://picsum.photos/seed/37/600'),
          const SizedBox(
            height: 10.0,
          ),
          _boxTypeCard(
              widget.rewind,
              'Condividi un momento del passato con la persona cara.',
              'https://picsum.photos/seed/37/600'),
          const SizedBox(
            height: 10.0,
          ),
          _boxTypeCard(widget.messageInABottle, 'Rendi virale il tuo box.',
              'https://picsum.photos/seed/37/600')
        ],
      ),
    );
  }

  BoxType? _convert(String title) {
    BoxType? boxType;

    switch (title) {
      case 'message in a bottle':
        boxType = BoxType.messageInABottle;
      case 'future':
        boxType = BoxType.future;
      case 'rewind':
        boxType = BoxType.rewind;
    }

    return boxType;
  }

  Widget _boxTypeCard(String title, String caption, String imagePath) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        child: Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.light.primaryBackground,
                AppColors.light.secondary
              ],
              stops: const [0, 1],
              begin: const AlignmentDirectional(-1, 0),
              end: const AlignmentDirectional(1, 0),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                    Text(caption,
                        style: const TextStyle(
                            fontFamily: 'DM Sans', fontSize: 12)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        imagePath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          setState(() {
            widget.boxHelper.boxType = _convert(title.toLowerCase());
          });
        },
      ),
    );
  }
}
