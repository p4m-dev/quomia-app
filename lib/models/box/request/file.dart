import 'dart:typed_data';

import 'package:quomia/models/box/file_type.dart';

class File {
  final String name;
  final FileType fileType;
  final Uint8List content;

  const File(
      {required this.name, required this.fileType, required this.content});
}
