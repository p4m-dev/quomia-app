import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quomia/designSystem/button.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/info_message.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/screens/home_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/box/user_bottomsheet.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:quomia/widgets/common/custom_loader.dart';

class RewindFormStep extends StatefulWidget {
  final BoxHelper boxHelper;
  final GlobalKey<UserBottomSheetState> userBottomSheetKey;

  const RewindFormStep(
      {super.key, required this.boxHelper, required this.userBottomSheetKey});

  @override
  State<RewindFormStep> createState() => _RewindFormStepState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _RewindFormStepState extends State<RewindFormStep> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  String selectedFilePath = '';
  bool? _isAnonymousEnabled = false;
  bool isLoading = false;
  bool showMessage = true;
  List<String> menuList = <String>[
    '1 Anno',
    '2 Anni',
    '5 Anni',
    '10 Anni',
    '15 Anni',
    '20 Anni',
    '25 Anni',
    '30 Anni'
  ];

  late List<MenuEntry> menuEntries;
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    menuEntries = menuList
        .map<MenuEntry>((String name) => MenuEntry(value: name, label: name))
        .toList();
    dropdownValue = menuList.first;
  }

  @override
  void dispose() {
    _userController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _fileController.dispose();
    super.dispose();
  }

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
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InfoMessage(
                                    title: 'Rewind',
                                    content:
                                        'Stai acquistando un box temporale di tipo rewind',
                                    color: AppColors.light.tertiary,
                                    onClose: () {
                                      setState(() {
                                        showMessage = false;
                                      });
                                    },
                                  ),
                                  const Gap(height: 10.0),
                                  const Label(data: 'A chi desideri inviarlo?'),
                                  const Gap(height: 10.0),
                                  CustomTextFormField(
                                    width: double.infinity,
                                    controller: _userController,
                                    hintText: 'Nome utente',
                                    textInput: TextInputType.text,
                                    hasOnTap: true,
                                    callback: () {
                                      widget.userBottomSheetKey.currentState
                                          ?.openBottomSheet();
                                    },
                                  )
                                ],
                              ),
                              const Gap(height: 10.0),
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
                              const Gap(height: 20.0),
                              const Divider(
                                height: 5,
                              ),
                              const Gap(height: 20.0),
                              const Label(
                                data: 'Data di acquisto',
                                fontSize: 20,
                              ),
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
                              const Gap(height: 20.0),
                              const Label(
                                data:
                                    'Per quanto tempo desideri acquistarlo nel futuro?',
                              ),
                              const Gap(height: 10.0),
                              _datesDropdown(),
                              const Gap(height: 20.0),
                              const Divider(
                                height: 5,
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

  Widget _datesDropdown() {
    return DropdownButtonFormField<String>(
      value: dropdownValue,
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Seleziona il range di date',
        hintStyle: const TextStyle(fontFamily: 'DM Sans'),
        filled: true,
        fillColor: AppColors.light.background,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      items: menuList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      style: TextStyle(fontSize: 16, color: AppColors.light.primaryText),
      icon: Icon(Icons.arrow_drop_down, color: AppColors.light.primary),
      dropdownColor: AppColors.light.background,
    );
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
