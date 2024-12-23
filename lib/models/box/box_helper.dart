import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/models/box/box_type.dart';

class BoxHelper {
  static final BoxHelper _instance = BoxHelper._internal();

  factory BoxHelper() {
    return _instance;
  }

  BoxHelper._internal();

  // Box type
  final ValueNotifier<BoxType?> _boxType = ValueNotifier(null);

  ValueNotifier<BoxType?> get boxTypeNotifier => _boxType;

  set boxType(BoxType? type) {
    _boxType.value = type;
  }

  BoxType? get boxType => _boxType.value;

  // Category
  final ValueNotifier<Category?> _category = ValueNotifier(null);

  ValueNotifier<Category?> get categoryNotifier => _category;

  set category(Category? type) {
    _category.value = type;
  }

  Category? get category => _category.value;

  // File
  File get file => file;

  void reset() {
    _boxType.value = null;
    _category.value = null;
  }

  @override
  String toString() {
    return 'Box(boxType: $_boxType, category: $_category)';
  }
}
