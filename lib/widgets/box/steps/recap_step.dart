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

class RecapStep extends StatefulWidget {
  final BoxHelper boxHelper;
  final VoidCallback onStepCompleted;
  final VoidCallback onGoBack;
  final void Function(int) onStepClicked;

  const RecapStep(
      {super.key,
      required this.boxHelper,
      required this.onStepCompleted,
      required this.onGoBack,
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
                    onPressed: _goNext,
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

  void _goNext() {
    widget.onStepCompleted();
  }
}
