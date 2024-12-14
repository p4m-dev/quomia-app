import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quomia/designSystem/separator.dart';
import 'package:quomia/models/box_helper.dart';
import 'package:quomia/models/box_type.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/box/user_bottomsheet.dart';

class FormStep extends StatefulWidget {
  final BoxHelper boxHelper;

  const FormStep({super.key, required this.boxHelper});

  @override
  State<FormStep> createState() => _FormStepState();
}

class _FormStepState extends State<FormStep> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final GlobalKey<UserBottomSheetState> _userBottomSheetKey = GlobalKey();
  bool? _isAnonymousEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('Creazione Box'),
            const Separator(height: 10.0),
            _subtitle('Inserisci i dati necessari'),
            const Separator(height: 10.0),
            Container(
              width: double.infinity,
              height: 474,
              decoration: BoxDecoration(
                color: AppColors.light.primaryBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
                child: Stack(children: [
                  SafeArea(
                    top: true,
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // make it conditional based on what user has chosen in step 1.
                            _renderUserTextField(),
                            const Separator(height: 10.0),
                            _label('Inserisci un titolo'),
                            const Separator(height: 10.0),
                            _textFormField(
                                double.infinity,
                                _titleController,
                                'Titolo',
                                null,
                                null,
                                null,
                                null,
                                false,
                                TextInputType.text,
                                null),
                            const Separator(height: 10.0),
                            _label('Contenuto del messaggio'),
                            const Separator(height: 10.0),
                            _textFormField(
                                double.infinity,
                                _contentController,
                                'Messaggio',
                                null,
                                null,
                                null,
                                null,
                                false,
                                TextInputType.multiline,
                                null),
                            const Separator(height: 10.0),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label('Data'),
                                    const Separator(height: 10.0),
                                    _textFormField(
                                        155,
                                        _dateController,
                                        'Data',
                                        null,
                                        true,
                                        Icons.date_range,
                                        null,
                                        true,
                                        TextInputType.datetime, () {
                                      _selectDate(context);
                                    })
                                  ],
                                ),
                                const Separator(width: 10.0),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label('Tempo'),
                                    const Separator(height: 10.0),
                                    _textFormField(
                                        155,
                                        _timeController,
                                        'Tempo',
                                        null,
                                        true,
                                        Icons.timelapse,
                                        null,
                                        true,
                                        TextInputType.datetime, () {
                                      _selectTime(context);
                                    })
                                  ],
                                ),
                              ],
                            ),
                            const Separator(height: 10.0),
                            _label(
                                'Vuoi rivelare la tua identità alla persona cara?'),
                            const Separator(height: 10.0),
                            ListTileTheme(
                              horizontalTitleGap: 0.0,
                              child: CheckboxListTile(
                                  value: _isAnonymousEnabled,
                                  title: const Text("Anonimo"),
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: AppColors.light.secondary,
                                  checkColor: AppColors.light.tertiary,
                                  side: BorderSide(
                                      width: 2, color: AppColors.light.primary),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _isAnonymousEnabled = newValue;
                                    });
                                  }),
                            ),
                            const Separator(height: 10.0),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                _button(
                                    AppColors.light.tertiary, 'Annulla', () {}),
                                const Separator(height: 10.0),
                                _button(AppColors.light.primary, 'Sigilla', () {
                                  print('test');
                                }),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ]),
              ),
            ),
          ]),
    );
  }

  @override
  void dispose() {
    _userController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Text _title(String data) {
    return Text(data,
        style: const TextStyle(
            fontFamily: 'DM Sans', fontSize: 28, fontWeight: FontWeight.w600));
  }

  Text _label(String data) {
    return Text(data,
        style: const TextStyle(
            fontFamily: 'DM Sans', fontSize: 16, fontWeight: FontWeight.w600));
  }

  Text _subtitle(String data) {
    return Text(data,
        style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 16,
            color: AppColors.light.secondaryText));
  }

  Column _renderUserTextField() {
    return widget.boxHelper.boxType != BoxType.messageInABottle
        ? Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('A chi desideri inviarlo?'),
              const Separator(height: 10.0),
              _textFormField(double.infinity, _userController, 'Nome utente',
                  true, null, null, true, true, TextInputType.text, () {
                print('test');
                print(_userBottomSheetKey.currentState);
                _userBottomSheetKey.currentState?.openBottomSheet();
              })
            ],
          )
        : const Column();
  }

  Widget _textFormField(
      double width,
      TextEditingController controller,
      String hintText,
      bool? suffixIcon,
      bool? hasPrefixIcon,
      IconData? prefixIcon,
      bool? readOnly,
      bool? hasOnTap,
      TextInputType textInput,
      VoidCallback? callback) {
    var outlineBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0x00000000),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(24),
    );

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
            enabledBorder: outlineBorder,
            focusedBorder: outlineBorder,
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
            suffixIcon: suffixIcon != null && suffixIcon
                ? const Icon(
                    Icons.search_sharp,
                  )
                : null,
          ),
          readOnly: readOnly != null ? true : false,
          style: const TextStyle(fontFamily: 'DM Sans', fontSize: 14),
          cursorColor: AppColors.light.primaryText,
          onTap: hasOnTap != null && hasOnTap ? callback : null,
          keyboardType: textInput,
          maxLines: textInput == TextInputType.multiline ? 8 : null,
          maxLength: textInput == TextInputType.multiline ? 1000 : null),
    );
  }

  ElevatedButton _button(
      Color backgroundColor, String label, VoidCallback onPressed) {
    const size = Size(150, 48);

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: size,
            backgroundColor: backgroundColor,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26))),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
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
                      onSurface: AppColors.light.primaryText),
                  dialogBackgroundColor: AppColors.light.background),
              child: child!);
        });

    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
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
                    onSurface: AppColors.light.primaryText),
                dialogBackgroundColor: AppColors.light.background),
            child: child!);
      },
    );

    if (selectedTime != null) {
      setState(() {
        _timeController.text = selectedTime.format(context);
      });
    }
  }
}
