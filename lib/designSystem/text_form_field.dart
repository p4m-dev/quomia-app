import 'package:flutter/material.dart';
import 'package:quomia/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final double width;
  final TextEditingController controller;
  final String hintText;
  final bool? suffixIcon;
  final bool? hasPrefixIcon;
  final IconData? prefixIcon;
  final bool? readOnly;
  final bool? hasOnTap;
  final TextInputType textInput;
  final VoidCallback? callback;

  const CustomTextFormField(
      {super.key,
      required this.width,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      this.hasPrefixIcon,
      this.prefixIcon,
      this.readOnly,
      this.hasOnTap,
      required this.textInput,
      this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
          controller: controller,
          autofocus: false,
          obscureText: false,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: const TextStyle(fontFamily: 'DM Sans'),
            enabledBorder: _outlineInputBorder(),
            focusedBorder: _outlineInputBorder(),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.light.error,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.light.error,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            filled: true,
            fillColor: AppColors.light.background,
            prefixIcon: hasPrefixIcon != null
                ? Icon(
                    prefixIcon,
                  )
                : null,
            suffixIcon: suffixIcon != null && suffixIcon == true
                ? const Icon(
                    Icons.search_sharp,
                  )
                : null,
          ),
          readOnly: readOnly != null ? true : false,
          style: const TextStyle(fontFamily: 'DM Sans', fontSize: 14),
          cursorColor: AppColors.light.primaryText,
          onTap: hasOnTap != null && hasOnTap == true ? callback : null,
          keyboardType: textInput,
          maxLines: textInput == TextInputType.multiline ? 8 : null,
          maxLength: textInput == TextInputType.multiline ? 1000 : null),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0x00000000),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(24),
    );
  }
}
