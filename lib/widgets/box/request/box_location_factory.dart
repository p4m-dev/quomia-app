import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quomia/models/box/box_helper.dart';

class BoxLocationRequestFactory {
  final BoxHelper boxHelper;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final String fileExtension;
  final Uint8List fileBytes;

  BoxLocationRequestFactory({
    required this.boxHelper,
    required this.titleController,
    required this.contentController,
    required this.fileExtension,
    required this.fileBytes,
  });
}
