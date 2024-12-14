import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/designSystem/separator.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/models/box_helper.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/models/category.dart' as cat;

class BoxCategoryStep extends StatefulWidget {
  final BoxHelper boxHelper;

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
            const Separator(
              height: 10.0,
            ),
            const Subtitle(data: 'Che categoria di Box desideri acquistare?'),
            SizedBox(
              height: 300,
              child: GridView(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                scrollDirection: Axis.vertical,
                children: [
                  _categoryCard('Video', FontAwesomeIcons.video),
                  _categoryCard('Immagine', FontAwesomeIcons.image),
                  _categoryCard('Testo', FontAwesomeIcons.envelopeOpenText),
                  _categoryCard('Audio', FontAwesomeIcons.fileAudio)
                ],
              ),
            ),
          ]),
    );
  }

  Widget _categoryCard(String title, IconData icon) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        child: Container(
          width: 60,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.light.primaryBackground,
                AppColors.light.secondary
              ],
              stops: const [0, 1],
              begin: const AlignmentDirectional(0, -1),
              end: const AlignmentDirectional(0, 1),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 10),
                FaIcon(
                  icon,
                  color: AppColors.light.primaryText,
                  size: 48,
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          setState(() {
            widget.boxHelper.category = _convert(title.toLowerCase());
          });
        },
      ),
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
