import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quomia/utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? rememberMe = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light.background,
      body: SafeArea(
          top: true,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Container(
                    width: 399,
                    height: 500,
                    decoration: BoxDecoration(
                      color: AppColors.light.primaryBackground,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text('Accedi',
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 24,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                            child: Text('Bentornato',
                                style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w300,
                                ))),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
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
                                  letterSpacing: 0.0,
                                ),
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
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.light.background,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.light.background,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                filled: true,
                                fillColor: AppColors.light.background,
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                ),
                              ),
                              style: const TextStyle(
                                fontFamily: 'DM Sans',
                                letterSpacing: 0.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 0, 15, 0),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              controller: passwordController,
                              autofocus: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                  isDense: false,
                                  labelStyle: const TextStyle(
                                    fontFamily: 'DM Sans',
                                    letterSpacing: 0.0,
                                  ),
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(
                                    fontFamily: 'DM Sans',
                                    letterSpacing: 0.0,
                                  ),
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
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.light.background,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.light.background,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.light.background,
                                  prefixIcon: const Icon(
                                    Icons.key,
                                  ),
                                  suffixIcon: const Icon(Icons.visibility)),
                              style: const TextStyle(
                                fontFamily: 'DM Sans',
                                letterSpacing: 0.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  backgroundColor: AppColors.light.primary,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(26))),
                              onPressed: () {
                                print("test");
                              },
                              child: const Text(
                                "Accedi",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                          child: ListTileTheme(
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
                                    width: 2, color: AppColors.light.primary),
                                onChanged: (newValue) {
                                  setState(() {
                                    rememberMe = newValue;
                                  });
                                }),
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                          indent: 15,
                          endIndent: 15,
                          color: Color(0xFFF0F0F0),
                        ),
                        const Text('Accedi con',
                            style: TextStyle(fontFamily: 'DM Sans')),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              color: Colors.red,
                              iconSize: 40,
                              icon: const Icon(Icons.browser_not_supported),
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
                              iconSize: 40,
                              icon: const Icon(Icons.facebook),
                              onPressed: () {
                                setState(
                                  () {
                                    print("facebook login");
                                  },
                                );
                              },
                            ),
                            IconButton(
                              color: Colors.lightBlue,
                              iconSize: 40,
                              icon: const Icon(Icons.facebook),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Non possiedi un account?',
                                style: TextStyle(
                                    fontFamily: 'DM Sans', letterSpacing: 0.0),
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
                )
              ],
            ),
          )),
    );
  }
}
