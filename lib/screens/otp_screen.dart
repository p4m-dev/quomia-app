import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quomia/screens/home_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/auth/carousel.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController pinCodeController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _handleOtpValidation() async {
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
          const SnackBar(content: Text('Login avvenuto con successo!')),
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    pinCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light.background,
        body: Stack(children: [
          SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Carousel(),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.light.primaryBackground,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 0, 15, 0),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Text('Controlla la tua mail',
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600)),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text('simonezanetti7@gmail.com',
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.light.tertiary)),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text(
                                  'Se questo account esiste riceverai una mail con un codice di verifica utilizzabile solo una volta (OTP). ',
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 15),
                                    child: RichText(
                                      textScaler:
                                          MediaQuery.of(context).textScaler,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Copia e incolla il codice',
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    AppColors.light.tertiary),
                                          ),
                                          TextSpan(
                                              text: ' ricevuto via mail.',
                                              style: TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.normal,
                                                  color:
                                                      AppColors.light.tertiary))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 15, 15),
                                  child: PinCodeTextField(
                                    autoDisposeControllers: false,
                                    appContext: context,
                                    length: 6,
                                    textStyle:
                                        const TextStyle(fontFamily: 'DM Sans'),
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    enableActiveFill: false,
                                    autoFocus: true,
                                    enablePinAutofill: false,
                                    errorTextSpace: 16,
                                    showCursor: true,
                                    cursorColor: AppColors.light.primary,
                                    obscureText: false,
                                    keyboardType: TextInputType.number,
                                    pinTheme: PinTheme(
                                      fieldHeight: 44,
                                      fieldWidth: 44,
                                      borderWidth: 2,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      shape: PinCodeFieldShape.circle,
                                      activeColor: AppColors.light.primaryText,
                                      // Switch to alternate
                                      inactiveColor:
                                          AppColors.light.primaryText,
                                      selectedColor: AppColors.light.primary,
                                    ),
                                    controller: pinCodeController,
                                    onChanged: (_) {},
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    //validator: ,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 15, 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size(double.infinity, 50),
                                          backgroundColor:
                                              AppColors.light.primary,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(26))),
                                      onPressed: _handleOtpValidation,
                                      child: const Text(
                                        "Accedi",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )),
                                ),
                                RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text:
                                              'Le email potrebbero impiegare un pò di minuti prima che arrivino. \nSe non hai ricevuto nessun ',
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color:
                                                  AppColors.light.primaryText)),
                                      TextSpan(
                                        text: 'codice',
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.light.tertiary),
                                      ),
                                      TextSpan(
                                        text: ', ti chiediamo di riprovare. \n',
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.light.primaryText),
                                      ),
                                      TextSpan(
                                        text:
                                            'Se stai riscontrando altri problemi, ti chediamo di visitare la nostra pagina di ',
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.light.primaryText),
                                      ),
                                      TextSpan(
                                        text: 'supporto',
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.light.tertiary),
                                      ),
                                      TextSpan(
                                        text: '.',
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.light.primaryText),
                                      )
                                    ],
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        color: AppColors.light.primaryText),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
