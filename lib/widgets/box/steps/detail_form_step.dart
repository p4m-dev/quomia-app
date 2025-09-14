import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quomia/designSystem/button.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/box/steps/media_textfield.dart';
import 'package:quomia/widgets/maps/location_picker.dart';

class DetailFormStep extends StatefulWidget {
  final VoidCallback onStepCompleted;
  final VoidCallback onGoBack;

  const DetailFormStep(
      {super.key, required this.onStepCompleted, required this.onGoBack});

  @override
  State<DetailFormStep> createState() => _DetailFormStepState();
}

class _DetailFormStepState extends State<DetailFormStep> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  double? _latitude;
  double? _longitude;

  final _formKey = GlobalKey<FormState>();

  late Map<String, dynamic> selectedFile;
  Uint8List _fileBytes = Uint8List(0);
  String _fileExtension = '';
  late String _fileName;
  late String _filePath;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _dateStartController.dispose();
    _timeStartController.dispose();
    _dateEndController.dispose();
    _timeEndController.dispose();
    _fileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(data: 'NFT & Sicurezza'),
            const Gap(height: 10.0),
            const Subtitle(
                data: "Inserisci i dati necessari per completare l'acquisto"),
            const Gap(height: 10.0),
            Form(
              key: _formKey,
              child: Container(
                width: double.infinity,
                height: 440,
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
                              const Label(data: 'Inserisci un titolo'),
                              const Gap(height: 10.0),
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
