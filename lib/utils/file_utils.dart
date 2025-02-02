import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:video_compress/video_compress.dart';

class FileUtils {
  static FileType convertExtensionToFileType(String fileExtension) {
    switch (fileExtension) {
      case 'jpg':
        return FileType.image;
      case 'png':
        return FileType.image;
      case 'mp4':
        return FileType.video;
      case 'mp3':
        return FileType.audio;
      case 'wav':
        return FileType.audio;
      default:
        return FileType.any;
    }
  }

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

    final file = result.files.single;

    final filePath = file.path;
    final fileName = file.name;
    final fileExtension = fileName.split('.').last.toLowerCase();
    final fileBytes = file.bytes;

    return {
      'filePath': filePath,
      'fileName': fileName,
      'fileBytes': fileBytes,
      'fileExtension': fileExtension
    };
  }

  static String retrieveContentType(String fileExtension) {
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

  static String buildFilePath(FileType fileType, String sender) {
    String basePath = "files/$sender";

    late String contentPath;

    switch (fileType) {
      case FileType.image:
        contentPath = "image";
        break;
      case FileType.audio:
        contentPath = "audio";
        break;
      case FileType.video:
        contentPath = 'video';
        break;
      default:
        contentPath = '';
    }

    return "$basePath/$contentPath";
  }

  static Future<File?> optimizeFile(String filePath) async {
    final info = await VideoCompress.compressVideo(
      filePath,
      quality: VideoQuality.DefaultQuality,
      deleteOrigin: false,
    );

    return info?.file;
  }
}
