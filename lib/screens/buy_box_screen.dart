import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/designSystem/gap.dart';
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
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: Alignment(0.0, 0.0),
                radius: 0.5,
                colors: [
                  Color(0xFF00BF63),
                  Color(0xFF377C45),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            elevation: 5,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    tooltip: 'Open navigation menu',
                    icon: const Icon(
                      Icons.home,
                      color: Colors.black,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                  ),
                  IconButton(
                    tooltip: 'Open navigation menu',
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 32,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: 'Open navigation menu',
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: 'Open navigation menu',
                    icon: const FaIcon(
                      FontAwesomeIcons.user,
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfileScreen()));
                    },
                  ),
                ])),
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
                      onStepChanged: _updateStep,
                      onBoxTypeChanged: _updateBoxType)
                  : const SizedBox(),
              _currentStep == 3
                  ? BoxCategoryStep(
                      boxHelper: boxHelper,
                      currentStep: _currentStep,
                      onStepChanged: _updateStep,
                    )
                  : const SizedBox(),
              _renderFormStep(),
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

  Widget _renderFormStep() {
    if (_currentStep == 4) {
      switch (_boxType) {
        case BoxType.rewind:
          return RewindFormStep(boxHelper: boxHelper);
        case BoxType.future:
          return FutureFormStep(boxHelper: boxHelper);
        case BoxType.messageInABottle:
          return SocialFormStep(boxHelper: boxHelper);
        default:
          return RewindFormStep(boxHelper: boxHelper);
      }
    }
    return const Gap();
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
