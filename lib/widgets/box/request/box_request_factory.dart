import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/box_type.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/models/box/request/box_request.dart';
import 'package:quomia/models/box/request/dates.dart';
import 'package:quomia/models/box/request/file_item.dart';
import 'package:quomia/models/box/request/range.dart';
import 'package:quomia/utils/date_utils.dart';
import 'package:quomia/utils/file_utils.dart';
import 'package:quomia/utils/image_utils.dart';

class BoxRequestFactory {
  final BoxHelper boxHelper;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final TextEditingController dateStartController;
  final TextEditingController timeStartController;
  final TextEditingController dateEndController;
  final TextEditingController timeEndController;
  final String? downloadUrl;
  final String fileExtension;
  final bool isImage;
  final Uint8List fileBytes;
  final String? videoThumbnailUrl;
  final String? receiver;
  final BoxType boxType;
  final List<DateTime>? futureDates;
  final bool? isAnonymous;
  final TextEditingController? deliveryDateController;
  final TextEditingController? deliveryTimeController;

  BoxRequestFactory(
      {required this.boxHelper,
      required this.titleController,
      required this.contentController,
      required this.dateStartController,
      required this.timeStartController,
      required this.dateEndController,
      required this.timeEndController,
      required this.downloadUrl,
      required this.fileExtension,
      required this.isImage,
      required this.fileBytes,
      required this.videoThumbnailUrl,
      required this.receiver,
      required this.boxType,
      this.futureDates,
      this.isAnonymous,
      this.deliveryDateController,
      this.deliveryTimeController});

  Future<BoxRequest> createBoxRequest() async {
    return BoxRequest(
        sender: 'Samuel Maggio',
        receiver: receiver ?? '',
        title: titleController.text,
        type: BoxType.social,
        category: _getCategory(),
        file: await _getFileItem(),
        message: _getMessage(),
        dates: _getDates(),
        isAnonymous: isAnonymous ?? false);
  }

  Category _getCategory() {
    return boxHelper.category ?? Category.text;
  }

  Future<FileItem?> _getFileItem() async {
    if (boxHelper.category == Category.interactive) {
      return FileItem(
          fileType: FileUtils.convertExtensionToFileType(fileExtension),
          downloadUrl: downloadUrl ?? '',
          videoThumbnailUrl: videoThumbnailUrl == '' ? null : videoThumbnailUrl,
          imageBlurhash:
              isImage ? await ImageUtils.generateBlurHash(fileBytes) : '');
    }
    return null;
  }

  String? _getMessage() {
    return boxHelper.category == Category.text ? contentController.text : null;
  }

  Dates _getDates() {
    return Dates(
      range: Range(
        start: CustomDateUtils.transformDate(
            dateStartController.text, timeStartController.text),
        end: CustomDateUtils.transformDate(
            dateEndController.text, timeEndController.text),
      ),
      future: futureDates,
      deliveryDate: _getDeliveryDate(),
    );
  }

  DateTime? _getDeliveryDate() {
    return (deliveryDateController?.text.isNotEmpty ?? false) &&
            (deliveryTimeController?.text.isNotEmpty ?? false)
        ? CustomDateUtils.transformDate(
            deliveryDateController!.text, deliveryTimeController!.text)
        : null;
  }
}
