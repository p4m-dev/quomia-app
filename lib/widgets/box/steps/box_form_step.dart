import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quomia/designSystem/button.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/info_message.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/box/steps/media_textfield.dart';
import 'package:quomia/widgets/box/user_bottomsheet.dart';
import 'package:quomia/widgets/maps/location_picker.dart';

class BoxFormStep extends StatefulWidget {
  final BoxHelper boxHelper;
  final VoidCallback onStepCompleted;
  final VoidCallback onGoBack;

  const BoxFormStep(
      {super.key,
      required this.boxHelper,
      required this.onStepCompleted,
      required this.onGoBack});

  @override
  State<BoxFormStep> createState() => _BoxFormStepState();
}

class _BoxFormStepState extends State<BoxFormStep> {
  final TextEditingController _userController = TextEditingController();
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
    _userController.dispose();
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
            const CustomTitle(data: 'Crea il tuo Ricordo'),
            const Gap(height: 10.0),
            const Subtitle(data: "Inserisci i dati e dai vita al tuo Ricordo"),
            const Gap(height: 10.0),
            Form(
              key: _formKey,
              child: Container(
                width: double.infinity,
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
                              InfoMessage(
                                  title: 'Info',
                                  content:
                                      'Dai un nome al tuo Ricordo e fissa un punto sulla mappa per non dimenticarlo mai.',
                                  color: AppColors.light.tertiary),
                              const Gap(height: 10.0),
                              const Gap(height: 10.0),
                              const Label(data: 'A chi desideri inviarlo?'),
                              const Gap(height: 10.0),
                              CustomTextFormField(
                                width: double.infinity,
                                controller: _userController,
                                hintText: 'Destinatario',
                                textInput: TextInputType.text,
                                hasOnTap: true,
                                hasSuffixIcon: true,
                                readOnly: true,
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      final selectedUser =
                                          await UserBottomSheetUtils
                                              .showUserBottomSheet(context);
                                      if (selectedUser != null) {
                                        setState(() {
                                          _userController.text = selectedUser;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.search)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Il Destinatario deve essere presente!';
                                  }
                                  return null;
                                },
                              ),
                              const Label(data: 'Inserisci un titolo'),
                              const Gap(height: 10.0),
                              CustomTextFormField(
                                  width: double.infinity,
                                  controller: _titleController,
                                  hintText: 'Titolo',
                                  hasOnTap: true,
                                  textInput: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Il Titolo deve essere presente!';
                                    }
                                    return null;
                                  }),
                              const Gap(height: 10.0),
                              const Label(data: 'Inserisci una località'),
                              const Gap(height: 10.0),
                              LocationPicker(
                                controller: _locationController,
                                onLocationSelected: (lat, lng) {
                                  setState(() {
                                    _latitude = lat;
                                    _longitude = lng;
                                  });
                                },
                              ),
                              const Gap(height: 10.0),
                              MediaTextFieldWidget(
                                  category: widget.boxHelper.category,
                                  contentController: _contentController,
                                  fileController: _fileController,
                                  onFileSelected: (fileData) {
                                    _fileExtension =
                                        fileData['fileExtension'] ?? '';
                                    _fileName = fileData['fileName'] ?? '';
                                    _filePath = fileData['filePath'] ?? '';
                                    _fileBytes = fileData['fileBytes'] ?? '';
                                  }),
                              const Gap(height: 20.0),
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
                                        onPressed: _handleBoxLocationCreation),
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

  void _handleBoxLocationCreation() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.boxHelper.receiver = _userController.text;
      widget.boxHelper.title = _titleController.text;
      widget.boxHelper.content = _contentController.text;
      widget.boxHelper.latitude = _latitude;
      widget.boxHelper.longitude = _longitude;
      widget.boxHelper.location = _locationController.text;

      if (widget.boxHelper.category == Category.interactive) {
        widget.boxHelper.fileName = _fileName;
        widget.boxHelper.fileExtension = _fileExtension;
        widget.boxHelper.fileBytes = _fileBytes;
        widget.boxHelper.filePath = _filePath;

        debugPrint("BoxHelper aggiornato: ${widget.boxHelper}");
      }

      widget.onStepCompleted();
    }
  }
}
