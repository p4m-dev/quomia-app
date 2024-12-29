import 'package:flutter/material.dart';
import 'package:quomia/designSystem/button.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/info_message.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:quomia/models/box/box_helper.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/screens/home_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/utils/date_utils.dart';
import 'package:quomia/utils/firebase_utils.dart';
import 'package:quomia/widgets/box/user_bottomsheet.dart';
import 'package:quomia/widgets/common/custom_loader.dart';

class RewindFormStep extends StatefulWidget {
  final BoxHelper boxHelper;

  const RewindFormStep({super.key, required this.boxHelper});

  @override
  State<RewindFormStep> createState() => _RewindFormStepState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _RewindFormStepState extends State<RewindFormStep> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  final TextEditingController _futureDateController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String selectedFilePath = '';
  bool? _isAnonymousEnabled = false;
  bool isLoading = false;
  bool showMessage = true;
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

  late List<MenuEntry> menuEntries;
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
    _dateController.dispose();
    _timeController.dispose();
    _fileController.dispose();
    _futureDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
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
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
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
                                          'Stai acquistando un box temporale di tipo rewind',
                                      color: AppColors.light.tertiary,
                                      onClose: () {
                                        setState(() {
                                          showMessage = false;
                                        });
                                      },
                                    ),
                                    const Gap(height: 10.0),
                                    const Label(
                                        data: 'A chi desideri inviarlo?'),
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
                                                    .showUserBottomSheet(
                                                        context);
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
                                _renderMediaTextField(),
                                const Gap(height: 20.0),
                                const Divider(
                                  height: 5,
                                ),
                                const Gap(height: 20.0),
                                const Label(
                                    data:
                                        'Seleziona una data passata di inizio'),
                                const Gap(height: 10.0),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Label(data: 'Data'),
                                        const Gap(height: 10.0),
                                        CustomTextFormField(
                                          width: 155,
                                          controller: _dateController,
                                          hintText: 'Data',
                                          hasPrefixIcon: true,
                                          prefixIcon: Icons.date_range,
                                          hasOnTap: true,
                                          textInput: TextInputType.datetime,
                                          callback: () {
                                            _selectDate(
                                                context, _dateController);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'La data deve essere presente!';
                                            }

                                            return null;
                                          },
                                        )
                                      ],
                                    ),
                                    const Gap(width: 10.0),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Label(data: 'Tempo'),
                                        const Gap(height: 10.0),
                                        CustomTextFormField(
                                            width: 155,
                                            controller: _timeController,
                                            hintText: 'Tempo',
                                            hasPrefixIcon: true,
                                            prefixIcon: Icons.timelapse,
                                            hasOnTap: true,
                                            textInput: TextInputType.datetime,
                                            callback: () {
                                              _selectTime(
                                                  context, _timeController);
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Il tempo deve essere presente!';
                                              }

                                              return null;
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                                const Gap(height: 20.0),
                                const Label(
                                    data: 'Seleziona una data passata di fine'),
                                const Gap(height: 10.0),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Label(data: 'Data'),
                                        const Gap(height: 10.0),
                                        CustomTextFormField(
                                          width: 155,
                                          controller: _dateEndController,
                                          hintText: 'Data',
                                          hasPrefixIcon: true,
                                          prefixIcon: Icons.date_range,
                                          hasOnTap: true,
                                          textInput: TextInputType.datetime,
                                          callback: () {
                                            _selectDate(
                                                context, _dateEndController);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'La data deve essere presente!';
                                            }

                                            return null;
                                          },
                                        )
                                      ],
                                    ),
                                    const Gap(width: 10.0),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Label(data: 'Tempo'),
                                        const Gap(height: 10.0),
                                        CustomTextFormField(
                                            width: 155,
                                            controller: _timeEndController,
                                            hintText: 'Tempo',
                                            hasPrefixIcon: true,
                                            prefixIcon: Icons.timelapse,
                                            hasOnTap: true,
                                            textInput: TextInputType.datetime,
                                            callback: () {
                                              _selectTime(
                                                  context, _timeEndController);
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Il tempo deve essere presente!';
                                              }

                                              return null;
                                            })
                                      ],
                                    ),
                                  ],
                                ),
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
                                        backgroundColor:
                                            AppColors.light.tertiary,
                                        label: 'Annulla',
                                        onPressed: () {}),
                                    const Gap(width: 10.0),
                                    Button(
                                        backgroundColor:
                                            AppColors.light.primary,
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
      ),
      if (isLoading) const CustomLoader()
    ]);
  }

  void _showBottomSheet() {
    var dates = CustomDateUtils.generateDateList(startDate, futureDate);

    showModalBottomSheet(
        backgroundColor: AppColors.light.primaryBackground,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: dates.length,
              itemBuilder: (context, index) {
                String formattedDate =
                    CustomDateUtils.fullFormat.format(dates[index]);

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
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 5));

      setState(() {
        isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Acquisto del box avvenuto correttamente! A breve riceverai una mail di conferma.')),
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    }
  }

  Column _renderMediaTextField() {
    return widget.boxHelper.category == Category.text
        ? Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(data: 'Contenuto del messaggio'),
              const Gap(height: 10.0),
              CustomTextFormField(
                  width: double.infinity,
                  controller: _contentController,
                  hintText: 'Messaggio',
                  textInput: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Si prega di inserire un messaggio!';
                    }
                    return null;
                  })
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(data: 'Carica un file'),
              const Gap(height: 10.0),
              CustomTextFormField(
                controller: _fileController,
                hintText: 'Aggiungi un file',
                textInput: TextInputType.text,
                readOnly: true,
                hasOnTap: true,
                callback: () async {
                  final selectedFile = await FirebaseUtils.selectFile();

                  if (selectedFile != null) {
                    setState(() {
                      selectedFilePath = selectedFile['fileName'];
                    });
                  }
                },
              )
            ],
          );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    var previousDate = DateTime.now().subtract(const Duration(days: 1));

    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: previousDate,
        firstDate: DateTime(1900, 1, 1),
        lastDate:
            DateTime(previousDate.year, previousDate.month, previousDate.day),
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
        controller.text = CustomDateUtils.dateFormat.format(selectedDate);
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
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
        controller.text = selectedTime.format(context);
      });
    }
  }
}
