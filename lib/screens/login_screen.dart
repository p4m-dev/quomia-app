import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/screens/home_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/common/custom_loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? rememberMe = false;
  bool obscureText = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

// Funzione per gestire il click su "Accedi"
  Future<void> _handleLogin() async {
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
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                'https://picsum.photos/seed/383/600',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                'https://picsum.photos/seed/86/600',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                'https://picsum.photos/seed/615/600',
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
                                    child: Text('Accedi',
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
                                      child: Text('Bentornato',
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
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: passwordController,
                                        autofocus: false,
                                        obscureText: obscureText,
                                        decoration: InputDecoration(
                                            isDense: false,
                                            labelStyle: const TextStyle(
                                              fontFamily: 'DM Sans',
                                            ),
                                            hintText: 'Password',
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
                                                color:
                                                    AppColors.light.background,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            filled: true,
                                            fillColor:
                                                AppColors.light.background,
                                            errorStyle: TextStyle(
                                                color: AppColors.light.error),
                                            prefixIcon: const Icon(
                                              Icons.key,
                                            ),
                                            suffixIcon: IconButton(
                                                icon: Icon(
                                                  obscureText
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    obscureText = !obscureText;
                                                  });
                                                })),
                                        style: const TextStyle(
                                          fontFamily: 'DM Sans',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'La password non può essere vuota';
                                          }

                                          if (value.length < 8) {
                                            return 'La password deve contenere almeno 8 caratteri';
                                          }

                                          final RegExp hasUppercase =
                                              RegExp(r'[A-Z]');
                                          final RegExp hasDigits =
                                              RegExp(r'[0-9]');
                                          final RegExp hasSpecialCharacters =
                                              RegExp(r'[!@#$%^&*(),.?":{}|<>]');

                                          if (!hasUppercase.hasMatch(value)) {
                                            return 'La password deve contenere almeno una lettera maiuscola';
                                          }

                                          if (!hasDigits.hasMatch(value)) {
                                            return 'La password deve contenere almeno un numero';
                                          }

                                          if (!hasSpecialCharacters
                                              .hasMatch(value)) {
                                            return 'La password deve contenere almeno un carattere speciale';
                                          }

                                          return null;
                                        },
                                      ),
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
                                      onPressed: _handleLogin,
                                      child: const Text(
                                        "Accedi",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )),
                                  ListTileTheme(
                                    horizontalTitleGap: 0.0,
                                    child: CheckboxListTile(
                                        value: rememberMe,
                                        title: const Text("Ricordami"),
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
                                  const Text('Accedi con',
                                      style: TextStyle(fontFamily: 'DM Sans')),
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
                                          'Non possiedi un account?',
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              letterSpacing: 0.0),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Your action here
                                          },
                                          child: Text(
                                            'Clicca qui!',
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
