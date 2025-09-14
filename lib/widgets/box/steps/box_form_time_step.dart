import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:quomia/designSystem/button.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/http/box_http.dart';
import 'package:quomia/http/constants.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/box_type.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/models/box/file_type.dart';
import 'package:quomia/screens/main_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/utils/file_utils.dart';
import 'package:quomia/utils/firebase_utils.dart';
import 'package:quomia/utils/message_utils.dart';
import 'package:quomia/utils/video_utils.dart';
import 'package:quomia/widgets/box/request/box_request_factory.dart';
import 'package:quomia/widgets/box/steps/date_time_row.dart';

class BoxFormTimeStep extends StatefulWidget {
  final BoxHelper boxHelper;
  final Function(bool) onLoading;
  final VoidCallback onStepCompleted;
  final VoidCallback onGoBack;

  const BoxFormTimeStep(
      {super.key,
      required this.boxHelper,
      required this.onLoading,
      required this.onStepCompleted,
      required this.onGoBack});

  @override
  State<BoxFormTimeStep> createState() => _BoxFormStepState();
}

class _BoxFormStepState extends State<BoxFormTimeStep> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();
  final TextEditingController _dateOpeningController = TextEditingController();
  final TextEditingController _timeOpeningController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late Map<String, dynamic> selectedFile;
  Uint8List _fileBytes = Uint8List(0);
  String _fileExtension = '';
  late String _fileName;
  late String _filePath;

  @override
  void dispose() {
    _dateStartController.dispose();
    _timeStartController.dispose();
    _dateEndController.dispose();
    _timeEndController.dispose();
    _dateOpeningController.dispose();
    _timeOpeningController.dispose();
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
                              const Label(
                                data: 'Data iniziale',
                              ),
                              const Gap(height: 10.0),
                              DateTimeRow(
                                dateController: _dateStartController,
                                timeController: _timeStartController,
                                isFutureDate: true,
                              ),
                              const Gap(height: 20.0),
                              const Label(
                                data: 'Data finale',
                              ),
                              const Gap(height: 10.0),
                              DateTimeRow(
                                dateController: _dateEndController,
                                timeController: _timeEndController,
                                isFutureDate: true,
                              ),
                              const Gap(height: 10.0),
                              const Gap(height: 10.0),
                              const Label(
                                data: 'Data Di Apertura',
                              ),
                              const Gap(height: 10.0),
                              DateTimeRow(
                                dateController: _dateOpeningController,
                                timeController: _timeOpeningController,
                                isFutureDate: true,
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
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MainScreen()));
                                        }),
                                  ),
                                  const Gap(width: 10.0),
                                  Expanded(
                                    child: Button(
                                        backgroundColor:
                                            AppColors.light.primary,
                                        label: 'Continua',
                                        onPressed: _handleBoxTimeCreation),
                                  )
                                ],
                              )
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

  void _handleBoxTimeCreation() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.boxHelper.startDate = _dateStartController.text;
      widget.boxHelper.startTime = _dateStartController.text;
      widget.boxHelper.endDate = _dateEndController.text;
      widget.boxHelper.endTime = _timeEndController.text;
      widget.boxHelper.openingDate = _timeEndController.text;
      widget.boxHelper.openingTime = _timeEndController.text;

      debugPrint("BoxHelper aggiornato: ${widget.boxHelper}");

      widget.onStepCompleted();
    }
  }

  Future<void> _handleBoxBuy() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        widget.onLoading(true);
      });

      String? videoThumbnailUrl = '';
      bool isImage = false;
      String? downloadUrl = '';

      // Upload file to firebase
      if (widget.boxHelper.category == Category.interactive) {
        FileType fileType =
            FileUtils.convertExtensionToFileType(_fileExtension);

        isImage = fileType.isImage;

        downloadUrl = await FirebaseUtils.uploadFileToStorage(
            filePath: _filePath,
            fileType: fileType,
            fileExtension: _fileExtension,
            sender: 'Samuel Maggio',
            fileName: _fileName);

        if (fileType.isVideo) {
          File? thumbnailFile = await VideoUtils.generateThumbnail(_filePath);

          videoThumbnailUrl = await FirebaseUtils.uploadThumbnailToStorage(
              fileType: FileType.image,
              fileExtension: 'jpg',
              sender: 'Samuel Maggio',
              file: thumbnailFile,
              fileName: _fileName);
        }
      }

      try {
        final boxRequestFactory = BoxRequestFactory(
            boxHelper: widget.boxHelper,
            titleController: _titleController,
            contentController: _contentController,
            dateStartController: _dateStartController,
            timeStartController: _timeStartController,
            dateEndController: _dateEndController,
            timeEndController: _timeEndController,
            downloadUrl: downloadUrl,
            fileExtension: _fileExtension,
            isImage: isImage,
            fileBytes: _fileBytes,
            videoThumbnailUrl: videoThumbnailUrl,
            receiver: null,
            boxType: BoxType.social);

        final boxRequest = await boxRequestFactory.createBoxRequest();

        HttpBoxService httpBoxService = HttpBoxService();
        var baseUrl = Constants.baseUrl;
        await httpBoxService.createBox(boxRequest, '$baseUrl/box/social');

        if (mounted) {
          MessageUtils.showToast("Acquisto del box avvenuto correttamente!",
              AppColors.light.tertiary, Colors.white);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        }
      } catch (e) {
        if (mounted) {
          MessageUtils.showToast("Errore durante l'acquisto del box: $e",
              AppColors.light.error, Colors.white);
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
