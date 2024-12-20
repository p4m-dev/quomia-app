import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/step_progress_view.dart';
import 'package:quomia/models/box_helper.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/appbar/custom_app_bar.dart';
import 'package:quomia/widgets/box/steps/box_category_step.dart';
import 'package:quomia/widgets/box/steps/box_type_step.dart';
import 'package:quomia/widgets/box/steps/form_step.dart';
import 'package:quomia/widgets/box/steps/intro_step.dart';
import 'package:quomia/widgets/box/user_bottomsheet.dart';

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
    'Pagamento'
  ];
  final BoxHelper boxHelper = BoxHelper();
  final GlobalKey<UserBottomSheetState> _userBottomSheetKey = GlobalKey();

  void _updateStep(int newStep) {
    print('newStep: $newStep');
    setState(() {
      _currentStep = newStep;
      print('_currentStep: $_currentStep');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _userBottomSheetKey,
        backgroundColor: AppColors.light.background,
        appBar: _appBar(),
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
                      currentStep: _currentStep,
                      onStepChanged: _updateStep)
                  : const SizedBox(),
              _currentStep == 3
                  ? BoxCategoryStep(
                      boxHelper: boxHelper,
                      currentStep: _currentStep,
                      onStepChanged: _updateStep,
                    )
                  : const SizedBox(),
              _currentStep == 4
                  ? FormStep(
                      userBottomSheetKey: _userBottomSheetKey,
                      boxHelper: boxHelper,
                    )
                  : const Gap(),
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
                  _currentStep == 1
                      ? TextButton(
                          onPressed: _enableNextButton(),
                          style: TextButton.styleFrom(
                              foregroundColor: AppColors.light.primary),
                          child: const Text('Avanti'))
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ));
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.light.primaryBackground,
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.light.primaryText,
            size: 26,
          ),
          onPressed: () async {}),
      title: Text('Quomia',
          style: TextStyle(
            fontFamily: 'DM Sans',
            color: AppColors.light.info,
            fontSize: 28,
          )),
      actions: const [],
      centerTitle: false,
    );
  }

  Row _buttonsRow() {
    return _currentStep == 1
        ? Row(
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
          )
        : const Row();
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
}
