import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/models/box/box_type.dart';

class BoxHelper {
  static final BoxHelper _instance = BoxHelper._internal();

  factory BoxHelper() => _instance;

  BoxHelper._internal();

  // Box type
  final ValueNotifier<BoxType?> _boxType = ValueNotifier(null);
  ValueNotifier<BoxType?> get boxTypeNotifier => _boxType;

  set boxType(BoxType? type) => _boxType.value = type;
  BoxType? get boxType => _boxType.value;

  // Category
  final ValueNotifier<Category?> _category = ValueNotifier(null);
  ValueNotifier<Category?> get categoryNotifier => _category;

  set category(Category? type) => _category.value = type;
  Category? get category => _category.value;

  String? title;
  String? content;

  double? latitude;
  double? longitude;
  String? location;

  String? fileName;
  String? fileExtension;
  Uint8List? fileBytes;
  File? file;

  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;

  void reset() {
    _boxType.value = null;
    _category.value = null;

    title = null;
    content = null;
    latitude = null;
    longitude = null;
    location = null;
    fileName = null;
    fileExtension = null;
    fileBytes = null;
    file = null;
    startDate = null;
    startTime = null;
    endDate = null;
    endTime = null;
  }

  @override
  String toString() {
    return 'Box(boxType: $_boxType, category: $_category, title: $title, content: $content, lat: $latitude, lng: $longitude, fileName: $fileName)';
  }
}
