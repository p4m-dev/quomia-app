import 'dart:typed_data';
import 'package:blurhash/blurhash.dart';

class ImageUtils {
  static Future<String?> generateBlurHash(Uint8List bytes) async {
    return BlurHash.encode(bytes, 4, 3);
  }
}
