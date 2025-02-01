import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/utils/file_utils.dart';
import 'package:quomia/utils/firebase_utils.dart';

class MediaTextFieldWidget extends StatefulWidget {
  final Category? category;
  final TextEditingController contentController;
  final TextEditingController fileController;
  final ValueChanged<Map<String, dynamic>>? onFileSelected;

  const MediaTextFieldWidget({
    super.key,
    required this.category,
    required this.contentController,
    required this.fileController,
    this.onFileSelected,
  });

  @override
  State<MediaTextFieldWidget> createState() => _MediaTextFieldWidgetState();
}

class _MediaTextFieldWidgetState extends State<MediaTextFieldWidget> {
  String? _selectedFilePath;

  @override
  Widget build(BuildContext context) {
    return widget.category == Category.text
        ? Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(data: 'Contenuto del messaggio'),
              const Gap(height: 10.0),
              CustomTextFormField(
                  width: double.infinity,
                  controller: widget.contentController,
                  hintText: 'Messaggio',
                  textInput: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Il Messaggio deve essere presente!';
                    }
                    return null;
                  }),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(data: 'Carica un file'),
              const Gap(height: 10.0),
              CustomTextFormField(
                  controller: widget.fileController,
                  hintText: 'Aggiungi un file',
                  textInput: TextInputType.text,
                  readOnly: true,
                  hasOnTap: true,
                  callback: () async {
                    final selectedFile = await FileUtils.selectFile();

                    setState(() {
                      _selectedFilePath = selectedFile['fileName'];
                      widget.fileController.text = _selectedFilePath ?? '';

                      if (widget.onFileSelected != null) {
                        widget.onFileSelected!(selectedFile);
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Il File deve essere presente!';
                    }
                    return null;
                  }),
            ],
          );
  }
}
