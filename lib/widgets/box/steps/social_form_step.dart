import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quomia/designSystem/button.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/box_type.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/screens/home_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:quomia/widgets/common/custom_loader.dart';

class SocialFormStep extends StatefulWidget {
  final BoxHelper boxHelper;

  const SocialFormStep({super.key, required this.boxHelper});

  @override
  State<SocialFormStep> createState() => _SocialFormStepState();
}

class _SocialFormStepState extends State<SocialFormStep> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  String selectedFilePath = '';
  bool? _isAnonymousEnabled = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTitle(data: 'Creazione Box'),
              const Gap(height: 10.0),
              const Subtitle(data: 'Inserisci i dati necessari'),
              const Gap(height: 10.0),
              Container(
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
                              CustomTextFormField(
                                  width: double.infinity,
                                  controller: _titleController,
                                  hintText: 'Titolo',
                                  hasOnTap: true,
                                  textInput: TextInputType.text),
                              const Gap(height: 10.0),
                              _renderMediaTextField(),
                              const Gap(height: 10.0),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Label(data: 'Data'),
                                      const Gap(height: 10.0),
                                      CustomTextFormField(
                                        width: 155,
                                        controller: _dateController,
                                        hintText: 'Data',
                                        hasPrefixIcon: true,
                                        prefixIcon: Icons.date_range,
                                        hasOnTap: true,
                                        textInput: TextInputType.datetime,
                                        callback: () {
                                          _selectDate(context);
                                        },
                                      )
                                    ],
                                  ),
                                  const Gap(width: 10.0),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Label(data: 'Tempo'),
                                      const Gap(height: 10.0),
                                      CustomTextFormField(
                                        width: 155,
                                        controller: _timeController,
                                        hintText: 'Tempo',
                                        hasPrefixIcon: true,
                                        prefixIcon: Icons.timelapse,
                                        hasOnTap: true,
                                        textInput: TextInputType.datetime,
                                        callback: () {
                                          _selectTime(context);
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Gap(height: 10.0),
                              const Label(
                                  data:
                                      'Vuoi rivelare la tua identità alla persona cara?'),
                              const Gap(height: 10.0),
                              ListTileTheme(
                                horizontalTitleGap: 0.0,
                                child: CheckboxListTile(
                                    value: _isAnonymousEnabled,
                                    title: const Text("Anonimo"),
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    activeColor: AppColors.light.secondary,
                                    checkColor: AppColors.light.tertiary,
                                    side: BorderSide(
                                        width: 2,
                                        color: AppColors.light.primary),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _isAnonymousEnabled = newValue;
                                      });
                                    }),
                              ),
                              const Gap(height: 10.0),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Button(
                                      backgroundColor: AppColors.light.tertiary,
                                      label: 'Annulla',
                                      onPressed: () {}),
                                  const Gap(width: 10.0),
                                  Button(
                                      backgroundColor: AppColors.light.primary,
                                      label: 'Sigilla',
                                      onPressed: _handleBoxBuy)
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
      ),
      if (isLoading) const CustomLoader()
    ]);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _fileController.dispose();
    super.dispose();
  }

  Future<void> _handleBoxBuy() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Acquisto del box avvenuto correttamente! A breve riceverai una mail di conferma.')),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  Column _renderMediaTextField() {
    return widget.boxHelper.category == Category.text
        ? Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(data: 'Contenuto del messaggio'),
              const Gap(height: 10.0),
              CustomTextFormField(
                  width: double.infinity,
                  controller: _contentController,
                  hintText: 'Messaggio',
                  textInput: TextInputType.multiline)
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(data: 'Carica un file'),
              const Gap(height: 10.0),
              CustomTextFormField(
                controller: _fileController,
                hintText: 'Aggiungi un file',
                textInput: TextInputType.text,
                readOnly: true,
                hasOnTap: true,
                callback: _pickFile,
              )
            ],
          );
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4', 'mp3', 'wav'],
        withData: true);

    if (result != null) {
      setState(() {
        selectedFilePath = result.files.single.name;
      });

      _fileController.text = selectedFilePath;

      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = selectedFilePath;

      final storageRef = FirebaseStorage.instance.ref();
      final folderRef = storageRef.child('testuser/image');
      final imageRef = folderRef.child(fileName);

      if (fileBytes != null) {
        print('saving');

        try {
          await imageRef.putData(fileBytes);
        } on FirebaseException catch (e) {
          print(e.stackTrace);
        }
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970, 1, 1),
        lastDate: DateTime(2150, 1, 1),
        confirmText: 'Conferma',
        cancelText: 'Annulla',
        builder: (context, child) {
          return Theme(
              data: ThemeData(
                  colorScheme: ColorScheme.light(
                      primary: AppColors.light.primary,
                      onPrimary: AppColors.light.primaryBackground,
                      onSurface: AppColors.light.primaryText),
                  dialogBackgroundColor: AppColors.light.background),
              child: child!);
        });

    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      confirmText: 'Conferma',
      cancelText: 'Annulla',
      builder: (context, child) {
        return Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(
                    primary: AppColors.light.primary,
                    onPrimary: AppColors.light.primaryBackground,
                    onSurface: AppColors.light.primaryText),
                dialogBackgroundColor: AppColors.light.background),
            child: child!);
      },
    );

    if (selectedTime != null) {
      setState(() {
        _timeController.text = selectedTime.format(context);
      });
    }
  }
}
