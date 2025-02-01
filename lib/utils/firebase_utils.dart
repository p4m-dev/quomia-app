import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:quomia/utils/file_utils.dart';

class FirebaseUtils {
  static Future<String?> uploadFileToFirebase(
      {required String filePath,
      required String fileExtension,
      required String sender}) async {
    final storageRef = FirebaseStorage.instance.ref();

    File? file = await FileUtils.optimizeFile(filePath);

    if (file == null) {
      print("Errore durante l'ottimizzazione del file");
      return null;
    }

    final folderPath = FileUtils.buildFilePath(fileExtension, sender);
    final folderRef = storageRef.child(folderPath);

    late String publicUrl;

    try {
      await folderRef.putFile(
          file,
          SettableMetadata(
            contentType: FileUtils.retrieveContentType(fileExtension),
          ));
      print('File caricato con successo: $file');

      publicUrl = await folderRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print('Errore durante il caricamento: ${e.message}');
      print(e.stackTrace);
      publicUrl = '';
    }

    return publicUrl;
  }
}
