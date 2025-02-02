import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quomia/designSystem/button.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/info_message.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/http/box_http.dart';
import 'package:quomia/http/constants.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/box_type.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/models/box/request/box_request.dart';
import 'package:quomia/models/box/request/dates.dart';
import 'package:quomia/models/box/request/file_item.dart';
import 'package:quomia/models/box/request/range.dart';
import 'package:quomia/screens/home_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/utils/date_utils.dart';
import 'package:quomia/utils/file_utils.dart';
import 'package:quomia/widgets/box/steps/date_time_row.dart';
import 'package:quomia/widgets/box/steps/media_textfield.dart';
import 'package:quomia/widgets/box/user_bottomsheet.dart';

class RewindFormStep extends StatefulWidget {
  final BoxHelper boxHelper;
  final Function(bool) onLoading;

  const RewindFormStep(
      {super.key, required this.boxHelper, required this.onLoading});

  @override
  State<RewindFormStep> createState() => _RewindFormStepState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _RewindFormStepState extends State<RewindFormStep> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  final TextEditingController _futureDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List<MenuEntry> menuEntries;
  late Uint8List _fileBytes;
  late String _fileExtension;
  late List<DateTime> _dates;
  late Map<String, dynamic> selectedFile;

  bool? _isAnonymousEnabled = false;
  List<String> menuList = <String>[
    '1 Anno',
    '2 Anni',
    '5 Anni',
    '10 Anni',
    '15 Anni',
    '20 Anni',
    '25 Anni',
    '30 Anni'
  ];
  String dropdownValue = '';
  DateTime futureDate = DateTime.now();
  DateTime previousDate = DateTime.now();
  DateTime startDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    menuEntries = menuList
        .map<MenuEntry>((String name) => MenuEntry(value: name, label: name))
        .toList();
    dropdownValue = menuList.first;
  }

  @override
  void dispose() {
    _userController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _dateStartController.dispose();
    _timeStartController.dispose();
    _dateEndController.dispose();
    _timeEndController.dispose();
    _fileController.dispose();
    _futureDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(data: 'Creazione Box'),
            const Gap(height: 10.0),
            const Subtitle(data: 'Inserisci i dati necessari'),
            const Gap(height: 10.0),
            Form(
              key: _formKey,
              child: Container(
                width: double.infinity,
                height: 440,
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
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InfoMessage(
                                    title: 'Rewind',
                                    content:
                                        'Stai acquistando un box temporale rewind',
                                    color: AppColors.light.tertiary,
                                  ),
                                  const Gap(height: 10.0),
                                  const Label(data: 'A chi desideri inviarlo?'),
                                  const Gap(height: 10.0),
                                  CustomTextFormField(
                                    width: double.infinity,
                                    controller: _userController,
                                    hintText: 'Destinatario',
                                    textInput: TextInputType.text,
                                    hasOnTap: true,
                                    hasSuffixIcon: true,
                                    readOnly: true,
                                    suffixIcon: IconButton(
                                        onPressed: () async {
                                          final selectedUser =
                                              await UserBottomSheetUtils
                                                  .showUserBottomSheet(context);
                                          if (selectedUser != null) {
                                            setState(() {
                                              _userController.text =
                                                  selectedUser;
                                            });
                                          }
                                        },
                                        icon: const Icon(Icons.search)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Il Destinatario deve essere presente!';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              const Gap(height: 10.0),
                              const Label(data: 'Inserisci un titolo'),
                              const Gap(height: 10.0),
                              CustomTextFormField(
                                width: double.infinity,
                                controller: _titleController,
                                hintText: 'Titolo',
                                hasOnTap: true,
                                textInput: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Il Titolo deve essere presente!';
                                  }
                                  return null;
                                },
                              ),
                              const Gap(height: 10.0),
                              MediaTextFieldWidget(
                                  category: widget.boxHelper.category,
                                  contentController: _contentController,
                                  fileController: _fileController,
                                  onFileSelected: (fileData) {
                                    _fileBytes = fileData['fileBytes'] ?? '';
                                    _fileExtension =
                                        fileData['fileExtension'] ?? '';
                                  }),
                              const Gap(height: 20.0),
                              const Divider(
                                height: 5,
                              ),
                              const Gap(height: 20.0),
                              const Label(
                                data:
                                    'Seleziona l intervallo di tempo che vuoi acquistare',
                                fontSize: 20,
                              ),
                              const Gap(height: 10.0),
                              const Label(
                                data: 'Tempo iniziale',
                              ),
                              const Gap(height: 10.0),
                              DateTimeRow(
                                  dateController: _dateStartController,
                                  timeController: _timeStartController),
                              const Gap(height: 20.0),
                              const Label(
                                data: 'Tempo finale',
                              ),
                              const Gap(height: 20.0),
                              DateTimeRow(
                                  dateController: _dateEndController,
                                  timeController: _timeEndController),
                              const Gap(height: 20.0),
                              const Label(
                                data:
                                    'Per quanto tempo desideri acquistarlo nel futuro?',
                              ),
                              const Gap(height: 10.0),
                              _datesDropdown(),
                              const Gap(height: 10.0),
                              const Label(
                                data: 'Data in cui il box verrà consegnato',
                              ),
                              const Gap(height: 10.0),
                              InfoMessage(
                                  title: 'Promemoria',
                                  content:
                                      'Lo slot temporale scelto indica che il messaggio verrà inoltrato al destinatario ogni anno al momento indicato fino alla data specificata.\nCliccando sul tasto info puoi vedere le date di consegna future.',
                                  color: AppColors.light.primary),
                              const Gap(height: 10.0),
                              CustomTextFormField(
                                  controller: _futureDateController,
                                  hintText: 'Data',
                                  textInput: TextInputType.datetime,
                                  readOnly: true,
                                  hasSuffixIcon: true,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        _showBottomSheet();
                                      },
                                      icon: const Icon(Icons.info_outline))),
                              const Gap(height: 20.0),
                              const Divider(
                                height: 5,
                              ),
                              const Gap(height: 10.0),
                              const Label(
                                  data:
                                      'Vuoi rivelare la tua identità alla persona cara?'),
                              const Gap(height: 10.0),
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
                                        width: 2,
                                        color: AppColors.light.primary),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _isAnonymousEnabled = newValue;
                                      });
                                    }),
                              ),
                              const Gap(height: 10.0),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Button(
                                      backgroundColor: AppColors.light.tertiary,
                                      label: 'Annulla',
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen()));
                                      }),
                                  const Gap(width: 10.0),
                                  Button(
                                      backgroundColor: AppColors.light.primary,
                                      label: 'Sigilla',
                                      onPressed: _handleBoxBuy)
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ]),
    );
  }

  void _showBottomSheet() {
    _dates = CustomDateUtils.generateDateList(startDate, futureDate);

    showModalBottomSheet(
        backgroundColor: AppColors.light.primaryBackground,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: _dates.length,
              itemBuilder: (context, index) {
                String formattedDate =
                    CustomDateUtils.fullFormat.format(_dates[index]);

                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.light.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Label(data: formattedDate),
                );
              },
            ),
          );
        });
  }

  Widget _datesDropdown() {
    return DropdownButtonFormField<String>(
      value: dropdownValue,
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Seleziona il range di date',
        hintStyle: const TextStyle(fontFamily: 'DM Sans'),
        filled: true,
        fillColor: AppColors.light.background,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      items: menuList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          futureDate = _convertDates(dropdownValue);

          print("FutureDate: $futureDate");

          String formattedDate = CustomDateUtils.fullFormat.format(futureDate);
          _futureDateController.text = formattedDate;
        });
      },
      style: TextStyle(fontSize: 16, color: AppColors.light.primaryText),
      icon: Icon(Icons.arrow_drop_down, color: AppColors.light.primary),
      dropdownColor: AppColors.light.background,
    );
  }

  DateTime _convertDates(String dropdownValue) {
    var timeText = _timeEndController.text;
    var dateText = _dateEndController.text;

    DateTime time = CustomDateUtils.timeFormat.parse(timeText);
    DateTime date = CustomDateUtils.dateFormat.parse(dateText);

    previousDate = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    startDate = CustomDateUtils.findNextFutureDate(previousDate);

    startDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      time.hour,
      time.minute,
    );

    DateTime futureLocalDate = DateTime.now();

    switch (dropdownValue) {
      case '1 Anno':
        futureLocalDate = CustomDateUtils.addYears(startDate, 1);
      case '2 Anni':
        futureLocalDate = CustomDateUtils.addYears(startDate, 2);
      case '5 Anni':
        futureLocalDate = CustomDateUtils.addYears(startDate, 5);
      case '10 Anni':
        futureLocalDate = CustomDateUtils.addYears(startDate, 10);
      case '15 Anni':
        futureLocalDate = CustomDateUtils.addYears(startDate, 15);
      case '20 Anni':
        futureLocalDate = CustomDateUtils.addYears(startDate, 20);
      case '25 Anni':
        futureLocalDate = CustomDateUtils.addYears(startDate, 25);
      case '30 Anni':
        futureLocalDate = CustomDateUtils.addYears(startDate, 30);
    }

    return DateTime(
      futureLocalDate.year,
      futureLocalDate.month,
      futureLocalDate.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> _handleBoxBuy() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        widget.onLoading(true);
      });

      // try {
      //   BoxRequest boxRequest = BoxRequest(
      //       sender: 'Samuel Maggio',
      //       receiver: _userController.text,
      //       title: _titleController.text,
      //       type: BoxType.rewind,
      //       category: widget.boxHelper.category ?? Category.text,
      //       isAnonymous: _isAnonymousEnabled,
      //       file: widget.boxHelper.category == Category.interactive
      //           ? File(
      //               name: _fileController.text,
      //               fileType:
      //                   FileUtils.convertExtensionToFileType(_fileExtension),
      //               content: _fileBytes)
      //           : null,
      //       message: widget.boxHelper.category == Category.text
      //           ? _contentController.text
      //           : null,
      //       dates: Dates(
      //           range: Range(
      //               start: CustomDateUtils.transformDate(
      //                   _dateStartController.text, _timeStartController.text),
      //               end: CustomDateUtils.transformDate(
      //                   _dateEndController.text, _timeEndController.text)),
      //           future: _dates));

      //   HttpBoxService httpBoxService = HttpBoxService();
      //   var baseUrl = Constants.baseUrl;
      //   await httpBoxService.createBox(boxRequest, '$baseUrl/box/rewind');

      //   if (mounted) {
      //     Fluttertoast.showToast(
      //       msg:
      //           "Acquisto del box avvenuto correttamente! A breve riceverai una mail di conferma.",
      //       toastLength: Toast.LENGTH_LONG,
      //       gravity: ToastGravity.TOP,
      //       backgroundColor: AppColors.light.tertiary,
      //       textColor: Colors.white,
      //       fontSize: 16.0,
      //     );

      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const HomeScreen()),
      //     );
      //   }
      // } catch (e) {
      //   if (mounted) {
      //     Fluttertoast.showToast(
      //       msg: "Errore durante l'acquisto del box: $e",
      //       toastLength: Toast.LENGTH_LONG,
      //       gravity: ToastGravity.TOP,
      //       backgroundColor: AppColors.light.error,
      //       textColor: Colors.white,
      //       fontSize: 16.0,
      //     );
      //   }
      // } finally {
      //   if (mounted) {
      //     setState(() {
      //       widget.onLoading(false);
      //     });
      //   }
      // }
    }
  }
}
