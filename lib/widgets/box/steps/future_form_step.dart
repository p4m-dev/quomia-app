import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quomia/designSystem/button.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/info_message.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/http/box_http.dart';
import 'package:quomia/http/constants.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/box_type.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/models/box/file_type.dart';
import 'package:quomia/models/box/request/box_request.dart';
import 'package:quomia/models/box/request/dates.dart';
import 'package:quomia/models/box/request/file.dart';
import 'package:quomia/models/box/request/range.dart';
import 'package:quomia/screens/home_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/utils/firebase_utils.dart';
import 'package:quomia/widgets/box/steps/date_time_row.dart';
import 'package:quomia/widgets/box/steps/media_textfield.dart';
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
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> selectedFile;
  late Uint8List _fileBytes;

  bool? _isAnonymousEnabled = false;
  bool isLoading = false;
  bool showMessage = true;
  String _selectedFilePath = '';

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InfoMessage(
                                        title: 'Future',
                                        content:
                                            'Stai acquistando un box temporale future',
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
                                  MediaTextFieldWidget(
                                      category: widget.boxHelper.category,
                                      contentController: _contentController,
                                      fileController: _fileController,
                                      onFileSelected: (fileData) {
                                        _selectedFilePath =
                                            fileData['fileName'] ?? '';
                                        _fileBytes = fileData['fileBytes'];
                                      }),
                                  const Gap(height: 20.0),
                                  const Divider(
                                    height: 5,
                                  ),
                                  const Gap(height: 20.0),
                                  const Label(
                                    data:
                                        'Seleziona l intervallo di tempo che vuoi acquistare',
                                    fontSize: 20,
                                  ),
                                  const Gap(height: 10.0),
                                  const Label(
                                    data: 'Tempo iniziale',
                                  ),
                                  const Gap(height: 10.0),
                                  DateTimeRow(
                                    dateController: _dateStartController,
                                    timeController: _timeStartController,
                                    isFutureDate: true,
                                  ),
                                  const Gap(height: 20.0),
                                  const Label(
                                    data: 'Tempo finale',
                                  ),
                                  const Gap(height: 20.0),
                                  DateTimeRow(
                                    dateController: _dateEndController,
                                    timeController: _timeEndController,
                                    isFutureDate: true,
                                  ),
                                  const Gap(height: 20.0),
                                  const Label(
                                    data:
                                        'Vuoi aggiungere una data di consegna?',
                                  ),
                                  const Gap(height: 20.0),
                                  DateTimeRow(
                                    dateController: _deliveryDateController,
                                    timeController: _deliveryTimeController,
                                    isFutureDate: true,
                                  ),
                                  const Gap(height: 20.0),
                                  const Divider(
                                    height: 5,
                                  ),
                                  const Gap(height: 20.0),
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen()));
                                          }),
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
      ),
      if (isLoading) const CustomLoader()
    ]);
  }

  @override
  void dispose() {
    _userController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _dateStartController.dispose();
    _timeStartController.dispose();
    _dateEndController.dispose();
    _timeEndController.dispose();
    _deliveryDateController.dispose();
    _deliveryTimeController.dispose();
    _fileController.dispose();
    super.dispose();
  }

  Future<void> _handleBoxBuy() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      BoxRequest boxRequest = BoxRequest(
          sender: 'Samuel Maggio',
          title: _titleController.text,
          type: BoxType.social,
          category: widget.boxHelper.category ?? Category.text,
          file: widget.boxHelper.category == Category.interactive
              ? File(
                  name: _fileController.text,
                  fileType: FileType.image,
                  content: _fileBytes)
              : null,
          message: widget.boxHelper.category == Category.text
              ? _contentController.text
              : null,
          dates:
              Dates(range: Range(start: DateTime.now(), end: DateTime.now())));

      HttpBoxService httpBoxService = HttpBoxService();
      var baseUrl = Constants.baseUrl;
      await httpBoxService.createBox(boxRequest, '$baseUrl/box/rewind');

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
}
