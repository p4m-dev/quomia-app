import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class FirebaseUtils {
  static Future<Map<String, dynamic>> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'mp4', 'mp3', 'wav'],
      withData: true,
    );

    if (result == null) {
      print('Nessun file selezionato.');
      return Map.identity();
    }

    final fileName = result.files.single.name;
    final fileExtension = fileName.split('.').last.toLowerCase();

    return {
      'fileName': fileName,
      'fileBytes': result.files.first.bytes,
      'fileExtension': fileExtension
    };
  }

  static Future<void> uploadFileToFirebase({
    required Uint8List fileBytes,
    required String fileName,
    required String folderPath,
  }) async {
    final storageRef = FirebaseStorage.instance.ref();
    final folderRef = storageRef.child(folderPath);
    final fileRef = folderRef.child(fileName);

    try {
      await fileRef.putData(fileBytes);
      print('File caricato con successo: $fileName');
    } on FirebaseException catch (e) {
      print('Errore durante il caricamento: ${e.message}');
      print(e.stackTrace);
    }
  }
}
