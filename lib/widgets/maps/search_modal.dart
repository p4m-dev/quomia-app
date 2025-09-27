import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/utils/app_colors.dart';

class AddressBottomSheet extends StatefulWidget {
  const AddressBottomSheet({super.key});

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // per evitare tastiera sopra
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Label(
            data: 'Inserisci Indirizzo',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          const Gap(height: 16),
          CustomTextFormField(
            controller: _controller,
            hintText: 'Indirizzo',
            textInput: TextInputType.text,
            hasPrefixIcon: true,
            prefixIcon: Icons.location_on,
          ),
          const Gap(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.light.primary,
              foregroundColor: AppColors.light.primaryBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              final address = _controller.text.trim();
              if (address.isNotEmpty) {
                Navigator.pop(context, address);
              }
            },
            child: const Text("Conferma"),
          ),
          const Gap(height: 8),
        ],
      ),
    );
  }
}
