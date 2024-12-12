// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:quomia/utils/app_colors.dart';
// import 'package:quomia/widgets/buy/creation_step.dart';

// class TextFormField extends StatelessWidget {
//   final double width;
//   final TextEditingController controller;
//   final String hintText;
//   final bool? suffixIcon;
//   final bool? hasPrefixIcon;
//   final IconData? prefixIcon;
//   final bool? readOnly;
//   final bool? hasOnTap;
//   final VoidCallback? callback;

//   const TextFormField(
//       {super.key,
//       required this.width,
//       required this.controller,
//       required this.hintText,
//       required this.suffixIcon,
//       required this.hasPrefixIcon,
//       required this.prefixIcon,
//       required this.readOnly,
//       required this.hasOnTap,
//       required this.callback});

//   @override
//   Widget build(BuildContext context) {
//     var outlineBorder = OutlineInputBorder(
//       borderSide: const BorderSide(
//         color: Color(0x00000000),
//         width: 1,
//       ),
//       borderRadius: BorderRadius.circular(24),
//     );

//     return SizedBox(
//       width: width,
//       child: TextFormField(
//         controller: controller,
//         autofocus: false,
//         obscureText: false,
//         decoration: InputDecoration(
//           isDense: true,
//           hintText: hintText,
//           hintStyle: const TextStyle(fontFamily: 'DM Sans'),
//           enabledBorder: outlineBorder,
//           focusedBorder: outlineBorder,
//           errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: AppColors.light.error,
//               width: 1,
//             ),
//             borderRadius: BorderRadius.circular(24),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: AppColors.light.error,
//               width: 1,
//             ),
//             borderRadius: BorderRadius.circular(24),
//           ),
//           filled: true,
//           fillColor: AppColors.light.background,
//           prefixIcon: hasPrefixIcon != null
//               ? Icon(
//                   prefixIcon,
//                 )
//               : null,
//           suffixIcon: suffixIcon != null && suffixIcon == true
//               ? const Icon(
//                   Icons.search_sharp,
//                 )
//               : null,
//         ),
//         readOnly: readOnly != null && readOnly == true ? true : false,
//         style: const TextStyle(fontFamily: 'DM Sans', fontSize: 14),
//         cursorColor: AppColors.light.primaryText,
//         onTap: hasOnTap != null && hasOnTap == true ? callback : null,
//       ),
//     );
//   }
// }
