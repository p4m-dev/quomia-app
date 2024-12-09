import 'package:flutter/material.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/buy/user_bottomsheet.dart';

class CreationStep extends StatefulWidget {
  const CreationStep({super.key});

  @override
  State<CreationStep> createState() => _CreationStepState();
}

class _CreationStepState extends State<CreationStep> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final GlobalKey<UserBottomSheetState> _userBottomSheetKey = GlobalKey();
  bool? _isAnonymousEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Creazione Box'),
          _divider(10.0, 0.0),
          _subtitle('Inserisci i dati necessari'),
          _divider(10.0, 0.0),
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
                          _label('A chi desideri inviarlo?'),
                          _divider(10.0, 0.0),
                          _textFormField(double.infinity, _userController,
                              'Nome utente', true, null, null, true, true),
                          _divider(10.0, 0.0),
                          _label('Inserisci un titolo'),
                          _divider(10.0, 0.0),
                          _textFormField(double.infinity, _titleController,
                              'Titolo', null, null, null, null, false),
                          _divider(10.0, 0.0),
                          _label('Contenuto del messaggio'),
                          _divider(10.0, 0.0),
                          _textFormField(double.infinity, _contentController,
                              'Messaggio', null, null, null, null, false),
                          _divider(10.0, 0.0),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _label('Data'),
                                  _divider(10.0, 0.0),
                                  _textFormField(155, _dateController, 'Data',
                                      null, true, Icons.date_range, null, false)
                                ],
                              ),
                              _divider(0.0, 10.0),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _label('Tempo'),
                                  _divider(10.0, 0.0),
                                  _textFormField(
                                      155,
                                      _timeController,
                                      'Tempo',
                                      null,
                                      true,
                                      Icons.time_to_leave,
                                      null,
                                      false)
                                ],
                              ),
                            ],
                          ),
                          _divider(10.0, 0.0),
                          _label(
                              'Vuoi rivelare la tua identità alla persona cara?'),
                          _divider(10.0, 0.0),
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
                          _divider(10.0, 0.0),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              _button(
                                  AppColors.light.tertiary, 'Annulla', () {}),
                              _divider(0.0, 10.0),
                              _button(
                                  AppColors.light.primary, 'Sigilla', () {}),
                            ],
                          ),
                        ]),
                  ),
                ),
              ]),
            ),
          ),
        ]);
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

  SizedBox _divider(double? height, double? width) {
    return SizedBox(height: height, width: width);
  }

  Widget _textFormField(
      double width,
      TextEditingController controller,
      String hintText,
      bool? suffixIcon,
      bool? hasPrefixIcon,
      IconData? prefixIcon,
      bool? readOnly,
      bool hasOnTap) {
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
          suffixIcon: suffixIcon != null
              ? const Icon(
                  Icons.search_sharp,
                )
              : null,
        ),
        readOnly: readOnly != null ? true : false,
        style: const TextStyle(fontFamily: 'DM Sans', fontSize: 14),
        cursorColor: AppColors.light.primaryText,
        onTap: hasOnTap
            ? () {
                print('test');
                print(_userBottomSheetKey.currentState);
                _userBottomSheetKey.currentState?.openBottomSheet();
              }
            : null,
      ),
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
}
