import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CustomImage extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final String blurHash;

  const CustomImage(
      {super.key,
      required this.width,
      required this.height,
      required this.imageUrl,
      required this.blurHash});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) => BlurHash(
          hash: blurHash,
          imageFit: BoxFit.cover,
          color: Colors.grey[300]!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fadeInDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}
