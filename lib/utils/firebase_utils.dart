import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quomia/models/box/file_type.dart';
import 'package:quomia/utils/file_utils.dart';
import 'dart:developer' as developer;

class FirebaseUtils {
  static Future<String?> uploadFileToStorage(
      {required String filePath,
      required FileType fileType,
      required String fileExtension,
      required String sender}) async {
    final storageRef = FirebaseStorage.instance.ref();

    // Compress file only if isVideo
    File? file = fileType.isVideo
        ? await FileUtils.optimizeFile(filePath)
        : File(filePath);

    if (file == null) {
      print("Errore durante l'ottimizzazione del file");
      return null;
    }

    final folderPath = FileUtils.buildFilePath(fileType, sender);

    final folderRef = storageRef.child(folderPath);

    return uploadFile(folderRef, file, fileExtension);
  }

  static Future<String?> uploadThumbnailToStorage(
      {required FileType fileType,
      required String fileExtension,
      required String sender,
      required File? file}) async {
    if (file == null) {
      print("Errore durante la generazione del thumbnail!");
      return null;
    }

    final storageRef = FirebaseStorage.instance.ref();

    final folderPath = FileUtils.buildFilePath(fileType, sender);

    final folderRef = storageRef.child(folderPath);

    return uploadFile(folderRef, file, fileExtension);
  }

  static Future<String> uploadFile(
      Reference folderRef, File file, String fileExtension) async {
    late String downloadUrl;

    try {
      await folderRef.putFile(
          file,
          SettableMetadata(
            contentType: FileUtils.retrieveContentType(fileExtension),
          ));

      developer.log('File caricato con successo: $file');

      downloadUrl = await folderRef.getDownloadURL();
    } on FirebaseException catch (e) {
      developer.log('Errore durante il caricamento: ${e.message}');
      developer.log(e.stackTrace.toString());
      downloadUrl = '';
    }

    return downloadUrl;
  }
}
