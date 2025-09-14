import 'package:flutter/material.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/step_progress_view.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/box/steps/box_category_step.dart';
import 'package:quomia/widgets/box/steps/box_form_step.dart';
import 'package:quomia/widgets/box/steps/box_form_time_step.dart';
import 'package:quomia/widgets/box/steps/detail_form_step.dart';
import 'package:quomia/widgets/box/steps/security_form_step.dart';
import 'package:quomia/widgets/common/custom_loader.dart';

class BuyBoxModal extends StatefulWidget {
  const BuyBoxModal({super.key});

  @override
  State<BuyBoxModal> createState() => _BuyBoxModalState();
}

class _BuyBoxModalState extends State<BuyBoxModal> {
  int _currentStep = 1;
  bool isLoading = false;

  final List<String> titles = [
    'Tipo',
    'Luogo',
    'Tempo',
    'Sicurezza',
    'Riepilogo'
  ];
  final BoxHelper boxHelper = BoxHelper();

  void _updateStep(int newStep) {
    setState(() {
      _currentStep = newStep;
    });
  }

  void _toggleLoading(bool show) {
    setState(() {
      isLoading = show;
    });
  }

  void _goToNextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _goBack() {
    setState(() {
      _currentStep--;
    });
  }

  VoidCallback? _enableNextButton() {
    VoidCallback? onPressed;

    if (_currentStep == 1) {
      onPressed = () {
        setState(() {
          _currentStep++;
        });
      };
    }
    return onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.light.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  AppBar(
                    backgroundColor: AppColors.light.background,
                    elevation: 0,
                    leading: const SizedBox
                        .shrink(), // Rimuovi il pulsante predefinito
                    title: Label(
                      data: 'Quomia',
                      color: AppColors.light.primary,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: AppColors.light.primaryText,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  StepProgressView(
                    titles: titles,
                    width: MediaQuery.of(context).size.width,
                    currentStep: _currentStep,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          if (_currentStep == 1)
                            BoxCategoryStep(
                              boxHelper: boxHelper,
                              currentStep: _currentStep,
                              onStepChanged: _updateStep,
                            ),
                          if (_currentStep == 2)
                            BoxFormStep(
                              boxHelper: boxHelper,
                              onLoading: _toggleLoading,
                              onStepCompleted: _goToNextStep,
                              onGoBack: _goBack,
                            ),
                          if (_currentStep == 3)
                            BoxFormTimeStep(
                                boxHelper: boxHelper,
                                onLoading: _toggleLoading,
                                onStepCompleted: _goToNextStep,
                                onGoBack: _goBack),
                          if (_currentStep == 4)
                            SecurityFormStep(
                              onStepCompleted: _goToNextStep,
                              onGoBack: _goBack,
                            ),
                          if (_currentStep == 5)
                            DetailFormStep(
                              onStepCompleted: _goToNextStep,
                              onGoBack: _goBack,
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (isLoading) const CustomLoader(),
            ],
          ),
        );
      },
    );
  }
}
