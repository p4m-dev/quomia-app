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
import 'package:quomia/widgets/box/steps/date_time_row.dart';
import 'package:quomia/widgets/box/steps/media_textfield.dart';
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
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> selectedFile;

  String _selectedFilePath = '';
  bool isLoading = false;

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
                                InfoMessage(
                                  title: 'Message in a bottle',
                                  content:
                                      'Stai acquistando un box temporale message in a bottle',
                                  color: AppColors.light.tertiary,
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
                                    onFileSelected: (filePath) {
                                      print(
                                          'Percorso del file selezionato: $filePath');
                                      _selectedFilePath = filePath ?? '';
                                    }),
                                const Gap(height: 20.0),
                                const Divider(
                                  height: 5,
                                ),
                                const Gap(height: 10.0),
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
                                const Gap(height: 10.0),
                                DateTimeRow(
                                  dateController: _dateEndController,
                                  timeController: _timeEndController,
                                  isFutureDate: true,
                                ),
                                const Gap(height: 10.0),
                                const Divider(
                                  height: 5,
                                ),
                                const Gap(height: 20.0),
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
      if (isLoading) const CustomLoader()
    ]);
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
}
