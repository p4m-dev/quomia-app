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
import 'package:quomia/utils/firebase_utils.dart';
import 'package:quomia/widgets/box/user_bottomsheet.dart';
import 'package:quomia/widgets/common/custom_loader.dart';

class FutureFormStep extends StatefulWidget {
  final BoxHelper boxHelper;

  const FutureFormStep({super.key, required this.boxHelper});

  @override
  State<FutureFormStep> createState() => _FutureFormStepState();
}

class _FutureFormStepState extends State<FutureFormStep> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> selectedFile;

  String _selectedFilePath = '';
  bool? _isAnonymousEnabled = false;
  bool isLoading = false;
  bool showMessage = true;

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
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
                    child: Stack(children: [
                      SafeArea(
                        top: true,
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InfoMessage(
                                      title: 'Future',
                                      content:
                                          'Stai acquistando un box temporale di tipo future',
                                      color: AppColors.light.tertiary,
                                      onClose: () {
                                        setState(() {
                                          showMessage = false;
                                        });
                                      },
                                    ),
                                    const Gap(height: 10.0),
                                    const Label(
                                        data: 'A chi desideri inviarlo?'),
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
                                                    .showUserBottomSheet(
                                                        context);
                                            if (selectedUser != null) {
                                              setState(() {
                                                _userController.text =
                                                    selectedUser;
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
                                    textInput: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Il Titolo deve essere presente!';
                                      }
                                      return null;
                                    }),
                                const Gap(height: 10.0),
                                _renderMediaTextField(),
                                const Gap(height: 20.0),
                                const Divider(
                                  height: 5,
                                ),
                                const Gap(height: 20.0),
                                const Label(
                                  data: 'Seleziona una data di acquisto',
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
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'La data deve essere presente!';
                                              }

                                              return null;
                                            })
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
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Il tempo deve essere presente!';
                                              }

                                              return null;
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                                const Gap(height: 20.0),
                                const Label(
                                  data: 'Seleziona una data di consegna',
                                ),
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Il tempo deve essere presente!';
                                      }

                                      return null;
                                    }),
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
                                        backgroundColor:
                                            AppColors.light.tertiary,
                                        label: 'Annulla',
                                        onPressed: () {}),
                                    const Gap(width: 10.0),
                                    Button(
                                        backgroundColor:
                                            AppColors.light.primary,
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
              ),
            ]),
      ),
      if (isLoading) const CustomLoader()
    ]);
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

  Future<void> _handleBoxBuy() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      // Check for file upload -> upload to firebase only if category is interactive.
      if (widget.boxHelper.category == Category.interactive) {
        Uint8List fileBytes = selectedFile['fileBytes'];

        FirebaseUtils.uploadFileToFirebase(
            fileBytes: fileBytes, fileName: _selectedFilePath, folderPath: '');
      }

      // TODO: add call to BE

      setState(() {
        isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Acquisto del box avvenuto correttamente! A breve riceverai una mail di conferma.')),
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
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
                callback: () async {
                  selectedFile = await FirebaseUtils.selectFile();

                  setState(() {
                    _selectedFilePath = selectedFile['fileName'];
                  });
                },
              )
            ],
          );
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
