import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/designSystem/step_progress_view.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/box_type.dart';
import 'package:quomia/screens/home_screen.dart';
import 'package:quomia/screens/user_profile_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/box/steps/box_category_step.dart';
import 'package:quomia/widgets/box/steps/box_type_step.dart';
import 'package:quomia/widgets/box/steps/future_form_step.dart';
import 'package:quomia/widgets/box/steps/intro_step.dart';
import 'package:quomia/widgets/box/steps/rewind_form_step.dart';
import 'package:quomia/widgets/box/steps/social_form_step.dart';
import 'package:quomia/widgets/common/custom_bottom_app_bar.dart';

class BuyBoxScreen extends StatefulWidget {
  const BuyBoxScreen({super.key});

  @override
  State<BuyBoxScreen> createState() => _BuyBoxScreenState();
}

class _BuyBoxScreenState extends State<BuyBoxScreen> {
  int _currentStep = 1;
  BoxType _boxType = BoxType.future;
  final List<String> titles = [
    'Intro',
    'Tipo',
    'Categoria',
    'Creazione',
    'Pagamento'
  ];
  final BoxHelper boxHelper = BoxHelper();

  void _updateStep(int newStep) {
    setState(() {
      _currentStep = newStep;
    });
  }

  void _updateBoxType(BoxType? newBoxType) {
    setState(() {
      if (newBoxType != null) {
        _boxType = newBoxType;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light.background,
        appBar: _appBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Cool FAB',
          shape: const CircleBorder(),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: const Alignment(0.0, 0.0),
                radius: 0.5,
                colors: [
                  AppColors.light.tertiary,
                  AppColors.light.primary,
                ],
              ),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.hourglass,
                color: AppColors.light.primaryText,
                size: 24,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomAppBar(onHomePressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }, onProfilePressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UserProfileScreen()));
        }),
        body: SafeArea(
          child: Column(
            children: [
              StepProgressView(
                  titles: titles,
                  width: MediaQuery.of(context).size.width,
                  currentStep: _currentStep),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (_currentStep == 1) const IntroStep(),
                      if (_currentStep == 2)
                        BoxTypeStep(
                            boxHelper: boxHelper,
                            currentStep: _currentStep,
                            onStepChanged: _updateStep,
                            onBoxTypeChanged: _updateBoxType),
                      if (_currentStep == 3)
                        BoxCategoryStep(
                          boxHelper: boxHelper,
                          currentStep: _currentStep,
                          onStepChanged: _updateStep,
                        ),
                      if (_currentStep == 4) _renderFormStep(),
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
                          if (_currentStep == 1)
                            TextButton(
                                onPressed: _enableNextButton(),
                                style: TextButton.styleFrom(
                                    foregroundColor: AppColors.light.primary),
                                child: const Text('Avanti')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _renderFormStep() {
    switch (_boxType) {
      case BoxType.rewind:
        return RewindFormStep(boxHelper: boxHelper);
      case BoxType.future:
        return FutureFormStep(boxHelper: boxHelper);
      case BoxType.social:
        return SocialFormStep(boxHelper: boxHelper);
      default:
        return RewindFormStep(boxHelper: boxHelper);
    }
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
