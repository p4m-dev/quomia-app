import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/utils/app_colors.dart';

class BuyBoxModal extends StatefulWidget {
  const BuyBoxModal({super.key});

  @override
  State<BuyBoxModal> createState() => _BuyBoxModalState();
}

class _BuyBoxModalState extends State<BuyBoxModal> {
  final chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.light.background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: AppBar(
                    backgroundColor: AppColors.light.background,
                    elevation: 0,
                    title: Label(
                      data: 'Test',
                      color: AppColors.light.primary,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    centerTitle: true,
                    leading: IconButton(
                      icon:
                          Icon(Icons.close, color: AppColors.light.primaryText),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const Gap(
                        height: 16.0,
                      ),
                      const Gap(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
