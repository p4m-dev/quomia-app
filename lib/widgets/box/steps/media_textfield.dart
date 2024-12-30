import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/utils/firebase_utils.dart';

class MediaTextFieldWidget extends StatefulWidget {
  final Category? category;
  final TextEditingController contentController;
  final TextEditingController fileController;
  final ValueChanged<String?>? onFileSelected;

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
              ),
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
                  final selectedFile = await FirebaseUtils.selectFile();

                  setState(() {
                    _selectedFilePath = selectedFile['fileName'];
                    widget.fileController.text = _selectedFilePath ?? '';

                    if (widget.onFileSelected != null) {
                      widget.onFileSelected!(_selectedFilePath);
                    }
                  });
                },
              ),
            ],
          );
  }
}
