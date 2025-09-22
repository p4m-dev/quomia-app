import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quomia/designSystem/button.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/utils/app_colors.dart';

class SecurityFormStep extends StatefulWidget {
  final VoidCallback onStepCompleted;
  final VoidCallback onGoBack;

  const SecurityFormStep(
      {super.key, required this.onStepCompleted, required this.onGoBack});

  @override
  State<SecurityFormStep> createState() => _BoxFormStepState();
}

class _BoxFormStepState extends State<SecurityFormStep> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(data: 'Sicurezza'),
            const Gap(height: 10.0),
            Form(
              key: _formKey,
              child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: AppColors.light.primaryBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
                  child: Stack(children: [
                    SafeArea(
                      top: true,
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Label(
                                data:
                                    'Ogni ricordo è unico e protetto, trasformato in un sigillo che ne garantisce l\'autenticità e la durata eterna.',
                                fontWeight: FontWeight.w300,
                              ),
                              const Gap(height: 10.0),
                              Center(
                                child: SvgPicture.asset(
                                  'assets/icons/nft.svg',
                                  height: 250,
                                  width: 250,
                                ),
                              ),
                              const Gap(height: 30.0),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Button(
                                        backgroundColor:
                                            AppColors.light.tertiary,
                                        label: 'Indietro',
                                        onPressed: _goBack),
                                  ),
                                  const Gap(width: 10.0),
                                  Expanded(
                                    child: Button(
                                        backgroundColor:
                                            AppColors.light.primary,
                                        label: 'Continua',
                                        onPressed: _goNext),
                                  )
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ]),
    );
  }

  void _goBack() {
    widget.onGoBack();
  }

  void _goNext() {
    widget.onStepCompleted();
  }
}
