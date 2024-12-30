import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/utils/date_utils.dart';

class DateTimeRow extends StatefulWidget {
  final TextEditingController dateController;
  final TextEditingController timeController;
  final bool? isFutureDate;

  const DateTimeRow(
      {super.key,
      required this.dateController,
      required this.timeController,
      this.isFutureDate});

  @override
  State<DateTimeRow> createState() => _DateTimeRowState();
}

class _DateTimeRowState extends State<DateTimeRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Label(data: 'Data'),
            const Gap(height: 10.0),
            CustomTextFormField(
              width: 155,
              controller: widget.dateController,
              hintText: 'Data',
              hasPrefixIcon: true,
              prefixIcon: Icons.date_range,
              hasOnTap: true,
              textInput: TextInputType.datetime,
              callback: () {
                if (widget.isFutureDate != null &&
                    widget.isFutureDate == true) {
                  _selectFutureDate(context);
                }
                _selectPastDate(context);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La data deve essere presente!';
                }
                return null;
              },
            ),
          ],
        ),
        const Gap(width: 10.0),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Label(data: 'Tempo'),
            const Gap(height: 10.0),
            CustomTextFormField(
              width: 155,
              controller: widget.timeController,
              hintText: 'Tempo',
              hasPrefixIcon: true,
              prefixIcon: Icons.timelapse,
              hasOnTap: true,
              textInput: TextInputType.datetime,
              callback: () {
                _selectTime(context);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Il tempo deve essere presente!';
                }
                return null;
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectPastDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970, 1, 1),
      lastDate: DateTime(2150, 1, 1),
      confirmText: 'Conferma',
      cancelText: 'Annulla',
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: AppColors.light.primary,
              onPrimary: AppColors.light.primaryBackground,
              onSurface: AppColors.light.primaryText,
            ),
            dialogBackgroundColor: AppColors.light.background,
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        widget.dateController.text =
            CustomDateUtils.dateFormat.format(selectedDate);
      });
    }
  }

  Future<void> _selectFutureDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now(),
      confirmText: 'Conferma',
      cancelText: 'Annulla',
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: AppColors.light.primary,
              onPrimary: AppColors.light.primaryBackground,
              onSurface: AppColors.light.primaryText,
            ),
            dialogBackgroundColor: AppColors.light.background,
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        widget.dateController.text =
            CustomDateUtils.dateFormat.format(selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      confirmText: 'Conferma',
      cancelText: 'Annulla',
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: AppColors.light.primary,
              onPrimary: AppColors.light.primaryBackground,
              onSurface: AppColors.light.primaryText,
            ),
            dialogBackgroundColor: AppColors.light.background,
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      setState(() {
        widget.timeController.text = selectedTime.format(context);
      });
    }
  }
}
