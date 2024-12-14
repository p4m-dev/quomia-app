import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/designSystem/separator.dart';
import 'package:quomia/designSystem/step_progress_view.dart';
import 'package:quomia/models/box_helper.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/box/steps/box_category_step.dart';
import 'package:quomia/widgets/box/steps/box_type_step.dart';
import 'package:quomia/widgets/box/steps/form_step.dart';
import 'package:quomia/widgets/box/steps/intro_step.dart';

class BuyBoxScreen extends StatefulWidget {
  const BuyBoxScreen({super.key});

  @override
  State<BuyBoxScreen> createState() => _BuyBoxScreenState();
}

class _BuyBoxScreenState extends State<BuyBoxScreen> {
  int _currentStep = 1;
  final List<String> titles = [
    'Intro',
    'Tipo',
    'Categoria',
    'Creazione',
    'Tempo'
  ];
  final BoxHelper boxHelper = BoxHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light.background,
        appBar: AppBar(
          backgroundColor: AppColors.light.primaryBackground,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: AppColors.light.primaryText,
                size: 30,
              ),
              onPressed: () async {}),
          title: Text('Quomia',
              style: TextStyle(
                fontFamily: 'DM Sans',
                color: AppColors.light.info,
                fontSize: 28,
              )),
          actions: [],
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              StepProgressView(
                  titles: titles,
                  width: MediaQuery.of(context).size.width,
                  currentStep: _currentStep),
              _currentStep == 1 ? const IntroStep() : const SizedBox(),
              _currentStep == 2
                  ? BoxTypeStep(
                      boxHelper: boxHelper,
                    )
                  : const SizedBox(),
              _currentStep == 3
                  ? BoxCategoryStep(
                      boxHelper: boxHelper,
                    )
                  : const SizedBox(),
              _currentStep == 4
                  ? FormStep(
                      boxHelper: boxHelper,
                    )
                  : const Separator(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: _currentStep > 1
                        ? () {
                            setState(() {
                              _currentStep--;
                            });
                          }
                        : null,
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.light.primary),
                    child: const Text('Indietro'),
                  ),
                  TextButton(
                      onPressed: _enableNextButton(),
                      style: TextButton.styleFrom(
                          foregroundColor: AppColors.light.primary),
                      child: const Text('Avanti')),
                ],
              ),
            ],
          ),
        ));
  }

  VoidCallback? _enableNextButton() {
    VoidCallback? onPressed;

    if (_currentStep == 2 && boxHelper.boxType == null) {
      onPressed = null;
    } else if (_currentStep == 3 && boxHelper.category == null) {
      onPressed = null;
    } else if (_currentStep < titles.length) {
      onPressed = () {
        setState(() {
          _currentStep++;
        });
      };
    }

    return onPressed;
  }
}
