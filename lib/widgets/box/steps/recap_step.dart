import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:quomia/designSystem/button.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/http/box_http.dart';
import 'package:quomia/http/constants.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/screens/main_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/utils/file_utils.dart';
import 'package:quomia/utils/firebase_utils.dart';
import 'package:quomia/utils/message_utils.dart';
import 'package:quomia/utils/video_utils.dart';
import 'package:quomia/widgets/box/request/box_request_factory.dart';
import 'package:quomia/models/box/file_type.dart';

class RecapStep extends StatefulWidget {
  final BoxHelper boxHelper;
  final VoidCallback onStepCompleted;
  final VoidCallback onGoBack;
  final Function(bool) onLoading;
  final void Function(int) onStepClicked;

  const RecapStep(
      {super.key,
      required this.boxHelper,
      required this.onStepCompleted,
      required this.onGoBack,
      required this.onLoading,
      required this.onStepClicked});

  @override
  State<RecapStep> createState() => _RecapStepState();
}

class _RecapStepState extends State<RecapStep> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();

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
    var boxHelper = widget.boxHelper;
    var startDate = "${boxHelper.startDate!} - ${boxHelper.startDate!}";
    var endDate = "${boxHelper.endDate!} - ${boxHelper.endTime!}";

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(data: 'Riepilogo'),
            const Gap(height: 10.0),
            const Subtitle(
                data:
                    'Controlla i dati inseriti prima di registrare il tuo ricordo'),
            const Gap(height: 20.0),

            // Title
            _buildSection(
              label: 'Titolo',
              value: boxHelper.title!,
              stepIndex: 1,
              icon: Icons.edit,
            ),

            // Location
            _buildSection(
                label: 'Località',
                value: boxHelper.location!,
                stepIndex: 2,
                icon: Icons.place),

            // File or content
            if (boxHelper.fileName != null)
              _buildSection(
                  label: 'File allegato',
                  value: boxHelper.fileName!,
                  stepIndex: 1,
                  icon: Icons.attach_file),

            if (boxHelper.content != null)
              _buildSection(
                  label: 'Contenuto',
                  value: boxHelper.content!,
                  stepIndex: 1,
                  icon: Icons.description),

            // Date
            _buildDateRangeSection(
                startDate: startDate, endDate: endDate, stepIndex: 3),

            const Gap(height: 10.0),

            // Bottoni
            Row(
              children: [
                Expanded(
                  child: Button(
                    backgroundColor: AppColors.light.tertiary,
                    label: 'Indietro',
                    onPressed: _goBack,
                  ),
                ),
                const Gap(width: 10.0),
                Expanded(
                  child: Button(
                    backgroundColor: AppColors.light.primary,
                    label: 'Conferma',
                    onPressed: _confirmBoxCreation,
                  ),
                ),
              ],
            )
          ]),
    );
  }

  Widget _buildSection({
    required String label,
    required String value,
    required int stepIndex,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.light.primaryBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
                const SizedBox(height: 6),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(icon, color: AppColors.light.primary),
            onPressed: () => widget.onStepClicked(stepIndex),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeSection({
    required String startDate,
    required String endDate,
    required int stepIndex,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.light.primaryBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Periodo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              IconButton(
                icon:
                    Icon(Icons.calendar_today, color: AppColors.light.primary),
                onPressed: () => widget.onStepClicked(stepIndex),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "Dal $startDate al $endDate",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _goBack() {
    widget.onGoBack();
  }

  Future<void> _confirmBoxCreation() async {
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
            latitude: widget.boxHelper.latitude,
            longitude: widget.boxHelper.longitude,
            street: widget.boxHelper.location);

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
