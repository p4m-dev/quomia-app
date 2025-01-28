import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/image.dart';
import 'package:quomia/utils/app_colors.dart';

class BoxCard extends StatelessWidget {
  final String title;
  final String caption;
  final String imagePath;
  final VoidCallback callback;

  const BoxCard(
      {super.key,
      required this.title,
      required this.caption,
      required this.imagePath,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        splashColor: Colors.white.withOpacity(0.3),
        highlightColor: Colors.white.withOpacity(0.1),
        onTap: callback,
        borderRadius: BorderRadius.circular(16),
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.black.withOpacity(0.1);
            }
            return null;
          },
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.light.primaryBackground,
                AppColors.light.secondary,
              ],
              stops: const [0, 1],
              begin: const AlignmentDirectional(-1, 0),
              end: const AlignmentDirectional(1, 0),
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(
                        height: 8.0,
                      ),
                      Text(
                        caption,
                        style: const TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 12,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Gap(
                  width: 16.0,
                ),
                CustomImage(
                    width: 100,
                    height: 100,
                    imageUrl: imagePath,
                    blurHash: "LEHV6nWB2yk8pyo0adR*.7kCMdnj")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
