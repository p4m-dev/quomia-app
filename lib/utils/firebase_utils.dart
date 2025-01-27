import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

import 'package:video_compress/video_compress.dart';

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

    final filePath = result.files.single.path;
    final fileName = result.files.single.name;
    final fileExtension = fileName.split('.').last.toLowerCase();

    return {
      'filePath': filePath,
      'fileName': fileName,
      'fileBytes': result.files.first.bytes,
      'fileExtension': fileExtension
    };
  }

  static String _retrieveContentType(String fileExtension) {
    switch (fileExtension) {
      case 'jpg':
        return 'image/jpg';
      case 'png':
        return 'image/png';
      case 'mp4':
        return "video/mp4";
      case 'mp3':
        return "audio/mp3";
      case 'wav':
        return "audio/wav";
      default:
        return "";
    }
  }

  static String _buildFilePath(String fileExtension, String sender) {
    String basePath = "files/$sender";

    late String contentPath;

    switch (fileExtension) {
      case 'png':
        contentPath = "image";
        break;
      case 'jpg':
        contentPath = "image";
        break;
      case 'wav':
        contentPath = "audio";
        break;
      case 'mp3':
        contentPath = "audio";
        break;
      case 'mp4':
        contentPath = "video";
        break;
    }

    return "$basePath/$contentPath";
  }

  static Future<File?> _optimizeFile(String filePath) async {
    final info = await VideoCompress.compressVideo(
      filePath,
      quality: VideoQuality.DefaultQuality,
      deleteOrigin: false,
    );

    return info?.file;
  }

  static Future<String?> uploadFileToFirebase(
      {required String filePath,
      required String fileExtension,
      required String sender}) async {
    final storageRef = FirebaseStorage.instance.ref();

    File? file = await _optimizeFile(filePath);

    if (file == null) {
      print("Errore durante l'ottimizzazione del file");
      return null;
    }

    final folderPath = _buildFilePath(fileExtension, sender);
    final folderRef = storageRef.child(folderPath);

    late String publicUrl;

    try {
      await folderRef.putFile(
          file,
          SettableMetadata(
            contentType: _retrieveContentType(fileExtension),
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
