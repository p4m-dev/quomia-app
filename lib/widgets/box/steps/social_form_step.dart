import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:quomia/utils/date_utils.dart';
import 'package:quomia/widgets/box/steps/date_time_row.dart';
import 'package:quomia/widgets/box/steps/media_textfield.dart';
import 'package:quomia/widgets/common/custom_loader.dart';

class SocialFormStep extends StatefulWidget {
  final BoxHelper boxHelper;
  final Function(bool) onLoading;

  const SocialFormStep(
      {super.key, required this.boxHelper, required this.onLoading});

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
  late Uint8List _fileBytes;
  late String _selectedFilePath;

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
                                  onFileSelected: (fileData) {
                                    _selectedFilePath =
                                        fileData['fileName'] ?? '';
                                    _fileBytes = fileData['fileBytes'];
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
                                      backgroundColor: AppColors.light.tertiary,
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
            ),
          ]),
    );
  }

  Future<void> _handleBoxBuy() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        widget.onLoading(true);
      });

      try {
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
            dates: Dates(
                range: Range(
                    start: CustomDateUtils.transformDate(
                        _dateStartController.text, _timeStartController.text),
                    end: CustomDateUtils.transformDate(
                        _dateEndController.text, _timeEndController.text))));

        HttpBoxService httpBoxService = HttpBoxService();
        var baseUrl = Constants.baseUrl;
        await httpBoxService.createBox(boxRequest, '$baseUrl/box/social');

        if (mounted) {
          Fluttertoast.showToast(
            msg:
                "Acquisto del box avvenuto correttamente! A breve riceverai una mail di conferma.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: AppColors.light.tertiary,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } catch (e) {
        if (mounted) {
          Fluttertoast.showToast(
            msg: "Errore durante l'acquisto del box: $e",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: AppColors.light.error,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            widget.onLoading(false);
          });
        }
      }
    }
  }
}
