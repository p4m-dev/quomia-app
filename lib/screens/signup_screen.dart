import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/screens/home_screen.dart';
import 'package:quomia/screens/login_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/common/custom_loader.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? rememberMe = false;
  bool obscureText = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> handleRegistration() async {
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
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light.background,
        body: Stack(
          children: [
            SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: CarouselSlider(
                          items: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: const Image(
                                image: AssetImage('assets/images/img_1.jpeg'),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: const Image(
                                image: AssetImage('assets/images/img_2.jpeg'),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: const Image(
                                image: AssetImage('assets/images/img_3.jpeg'),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                          carouselController: CarouselSliderController(),
                          options: CarouselOptions(
                            initialPage: 1,
                            viewportFraction: 0.5,
                            disableCenter: true,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.25,
                            enableInfiniteScroll: true,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                          ),
                        ),
                      ),
                      // Spacing
                      const SizedBox(height: 20),
                      Form(
                          key: _formKey,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.light.primaryBackground,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Text('Registrati',
                                        style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 24,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                                      child:
                                          Text('Crea un account per cominciare',
                                              style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w300,
                                              ))),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: TextFormField(
                                          controller: emailController,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: false,
                                            labelStyle: const TextStyle(
                                              fontFamily: 'DM Sans',
                                              letterSpacing: 0.0,
                                            ),
                                            hintText: 'Email',
                                            hintStyle: const TextStyle(
                                              fontFamily: 'DM Sans',
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.light.error,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.light.error,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            filled: true,
                                            fillColor:
                                                AppColors.light.background,
                                            prefixIcon: const Icon(
                                              Icons.email_outlined,
                                            ),
                                            errorStyle: TextStyle(
                                                color: AppColors.light.error),
                                          ),
                                          style: const TextStyle(
                                            fontFamily: 'DM Sans',
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'L\'email non può essere vuota';
                                            }

                                            final RegExp emailRegex = RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                            );

                                            if (!emailRegex.hasMatch(value)) {
                                              return 'Inserisci un\'email valida';
                                            }

                                            return null; // Email valida
                                          }),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size(double.infinity, 50),
                                          backgroundColor:
                                              AppColors.light.primary,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(26))),
                                      onPressed: handleRegistration,
                                      child: const Text(
                                        "Registrati",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )),
                                  const SizedBox(height: 10.0),
                                  ListTileTheme(
                                    horizontalTitleGap: 0.0,
                                    child: CheckboxListTile(
                                        value: rememberMe,
                                        title: const Text(
                                            "Ho letto i FAQ e aderisco ai termini e condizioni di Quomia"),
                                        contentPadding: EdgeInsets.zero,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        activeColor: AppColors.light.secondary,
                                        checkColor: AppColors.light.accent,
                                        side: BorderSide(
                                            width: 2,
                                            color: AppColors.light.primary),
                                        onChanged: (newValue) {
                                          setState(() {
                                            rememberMe = newValue;
                                          });
                                        }),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Expanded(child: Divider()),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Text(
                                          "O",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ),
                                      const Expanded(child: Divider()),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  const Text('Registrati con',
                                      style: TextStyle(
                                          fontFamily: 'DM Sans', fontSize: 16)),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        color: Colors.red,
                                        iconSize: 32,
                                        icon: const FaIcon(
                                            FontAwesomeIcons.google),
                                        onPressed: () {
                                          setState(
                                            () {
                                              print("facebook login");
                                            },
                                          );
                                        },
                                      ),
                                      IconButton(
                                        color: Colors.blue,
                                        iconSize: 32,
                                        icon: const FaIcon(
                                            FontAwesomeIcons.facebook),
                                        onPressed: () {
                                          setState(
                                            () {
                                              print("facebook login");
                                            },
                                          );
                                        },
                                      ),
                                      IconButton(
                                        color: Colors.black,
                                        iconSize: 32,
                                        icon: const FaIcon(
                                            FontAwesomeIcons.xTwitter),
                                        onPressed: () {
                                          setState(
                                            () {
                                              print("facebook login");
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Possiedi un account?',
                                          style:
                                              TextStyle(fontFamily: 'DM Sans'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen()));
                                          },
                                          child: Text(
                                            'Clicca qui',
                                            style: TextStyle(
                                              color: AppColors.light.accent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ])
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading) const CustomLoader()
          ],
        ));
  }
}
