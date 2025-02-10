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
      required String sender,
      required String fileName}) async {
    final storageRef = FirebaseStorage.instance.ref();

    File file = File(filePath);

    final folderPath = FileUtils.buildFilePath(fileType, sender);

    final fileRef = storageRef.child(folderPath).child(fileName);

    return uploadFile(fileRef, file, fileExtension);
  }

  static Future<String?> uploadThumbnailToStorage(
      {required FileType fileType,
      required String fileExtension,
      required String sender,
      required File? file,
      required String fileName}) async {
    if (file == null) {
      developer.log("Error during thumbnail generation!");
      return null;
    }

    final storageRef = FirebaseStorage.instance.ref();

    final folderPath = FileUtils.buildFilePath(fileType, sender);

    final fileRef = storageRef
        .child(folderPath)
        .child('thumbnail')
        .child("thumbnail_$fileName");

    return uploadFile(fileRef, file, fileExtension);
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

      developer.log('File uploaded successfully!: $file');

      downloadUrl = await folderRef.getDownloadURL();
    } on FirebaseException catch (e) {
      developer.log('Error during upload to firebase: ${e.message}');
      developer.log(e.stackTrace.toString());
      downloadUrl = '';
    }

    return downloadUrl;
  }
}
