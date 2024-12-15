import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileInputField extends StatefulWidget {
  @override
  _FileInputFieldState createState() => _FileInputFieldState();
}

class _FileInputFieldState extends State<FileInputField> {
  String? selectedFilePath;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4', 'mp3', 'wav'],
        withData: true);

    if (result != null) {
      setState(() {
        selectedFilePath = result.files.single.path!;
      });

      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;

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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Aggiungi file (immagine, video, audio)',
        suffixIcon: IconButton(
          icon: const Icon(Icons.attach_file),
          onPressed: _pickFile,
        ),
      ),
      controller: TextEditingController(text: selectedFilePath ?? ''),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Seleziona un file';
        }
        return null;
      },
    );
  }
}
