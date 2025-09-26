import 'dart:typed_data';

import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/models/box/location.dart';
import 'package:quomia/models/box/request/box_request.dart';
import 'package:quomia/models/box/request/dates.dart';
import 'package:quomia/models/box/request/file_item.dart';
import 'package:quomia/models/box/request/range.dart';
import 'package:quomia/utils/date_utils.dart';
import 'package:quomia/utils/file_utils.dart';
import 'package:quomia/utils/image_utils.dart';

class BoxRequestFactory {
  final BoxHelper boxHelper;
  final String content;
  final String dateStart;
  final String timeStart;
  final String dateEnd;
  final String timeEnd;
  final String title;
  final String? downloadUrl;
  final String? fileExtension;
  final bool isImage;
  final Uint8List? fileBytes;
  final String? videoThumbnailUrl;
  final String? receiver;

  // aggiunto per gestire location
  final double? longitude;
  final double? latitude;
  final String? street;

  BoxRequestFactory({
    required this.boxHelper,
    required this.title,
    required this.content,
    required this.dateStart,
    required this.timeStart,
    required this.dateEnd,
    required this.timeEnd,
    required this.downloadUrl,
    this.fileExtension,
    required this.isImage,
    this.fileBytes,
    required this.videoThumbnailUrl,
    required this.receiver,
    required this.longitude,
    required this.latitude,
    required this.street,
  });

  Future<BoxRequest> createBoxRequest() async {
    return BoxRequest(
        sender: 'Samuel Maggio',
        receiver: receiver ?? '',
        title: title,
        category: _getCategory(),
        file: await _getFileItem(),
        message: _getMessage(),
        dates: _getDates(),
        location: _getLocation());
  }

  Category _getCategory() {
    return boxHelper.category ?? Category.text;
  }

  Future<FileItem?> _getFileItem() async {
    if (boxHelper.category == Category.interactive) {
      return FileItem(
        fileType: FileUtils.convertExtensionToFileType(fileExtension ?? ''),
        downloadUrl: downloadUrl ?? '',
        videoThumbnailUrl: videoThumbnailUrl == '' ? null : videoThumbnailUrl,
        imageBlurhash: isImage
            ? await ImageUtils.generateBlurHash(
                fileBytes ?? Uint8List.fromList([]))
            : '',
      );
    }
    return null;
  }

  String? _getMessage() {
    return boxHelper.category == Category.text ? content : null;
  }

  Dates _getDates() {
    return Dates(
      range: Range(
        start: CustomDateUtils.transformDate(
          dateStart,
          timeStart,
        ),
        end: CustomDateUtils.transformDate(
          dateEnd,
          timeEnd,
        ),
      ),
    );
  }

  Location? _getLocation() {
    if (longitude != null && latitude != null && street != null) {
      return Location(
        longitude: longitude!,
        latitude: latitude!,
        street: street!,
      );
    }
    return null;
  }
}
