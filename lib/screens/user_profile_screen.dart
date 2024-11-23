import 'package:flutter/material.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quomia/widgets/user/chips_choice.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light.background,
        appBar: appBar(),
        body: Stack(
          children: [
            SafeArea(
              top: true,
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                              width: double.infinity,
                              height: 320,
                              decoration: BoxDecoration(
                                color: AppColors.light.primaryBackground,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const CircleAvatar(
                                              //backgroundColor: Colors.greenAccent[400],
                                              radius: 30,
                                              child: Text(
                                                'SM',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ), //Text
                                            ),
                                            buildItems('Box', '78', () {
                                              print('res');
                                            }),
                                            buildItems('Timers', '100', () {}),
                                            buildItems(
                                                'Chi segui', '20', () {}),
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        const Text(
                                          'Samuel Maggio',
                                          style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        const Text('Piano Gratuito',
                                            style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        const Text(
                                          'Sciacca, Italia',
                                          style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        const Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla vitae lacus scelerisque, pharetra risus vel, aliquam lacus. ...\n',
                                          style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 12,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    minimumSize: const Size(
                                                        40, 40),
                                                    backgroundColor: AppColors
                                                        .light.tertiary,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        26))),
                                                onPressed: () {
                                                  print('Button pressed ...');
                                                },
                                                child: const Text(
                                                  "Modifica profilo",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    minimumSize: const Size(
                                                        40, 40),
                                                    backgroundColor: AppColors
                                                        .light.primary,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        26))),
                                                onPressed: () {
                                                  print('Button pressed ...');
                                                },
                                                child: const Text(
                                                  "Passa a premium",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ))
                                          ],
                                        ),
                                      ]))),
                        ),
                        const SizedBox(height: 10.0),
                        buildStatsRow(),
                        const SizedBox(height: 10.0),
                        const Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Text('I tuoi Box',
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 20,
                              )),
                        ),
                        const ChoiceChips(),
                        SizedBox(
                          height: 300,
                          child: GridView(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                            scrollDirection: Axis.vertical,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://picsum.photos/seed/780/600',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://picsum.photos/seed/362/600',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://picsum.photos/seed/70/600',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://picsum.photos/seed/240/600',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])),
                ),
              ),
            )
          ],
        ));
  }

  Widget buildItems(String title, String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title,
              style: const TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: AppColors.light.primaryBackground,
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.light.primaryText,
            size: 30,
          ),
          onPressed: () async {
            //context.();
          }),
      title: Text('Samuel Maggio',
          style: TextStyle(
            fontFamily: 'DM Sans',
            color: AppColors.light.info,
            fontSize: 20,
          )),
      actions: [],
      centerTitle: false,
    );
  }

  Widget buildTopProfile() {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
          width: double.infinity,
          height: 315,
          decoration: BoxDecoration(
            color: AppColors.light.primaryBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          //backgroundColor: Colors.greenAccent[400],
                          radius: 100,
                          child: Text(
                            'GeeksForGeeks',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ), //Text
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Box',
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 16,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('20',
                                style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w300,
                                )),
                          ],
                        ),
                        const Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Timers',
                                style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '20',
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 14,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        const Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Chi segui',
                                style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '20',
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 14,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      'Samuel Maggio',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 18,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Piano Gratuito',
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 18,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        )),
                    const Text(
                      'Sciacca, Italia',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 14,
                        letterSpacing: 0.0,
                      ),
                    ),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla vitae lacus scelerisque, pharetra risus vel, aliquam lacus. ...\n',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 12,
                        letterSpacing: 0.0,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: AppColors.light.primary,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26))),
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            child: const Text(
                              "Modifica profilo",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: AppColors.light.primary,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26))),
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            child: const Text(
                              "Passa a premium",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ))
                      ],
                    ),
                  ]))),
    );
  }

  Widget buildStatsRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: 175,
            height: 175,
            decoration: BoxDecoration(
              color: AppColors.light.primaryBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Spazio Utilizzato',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 16,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CircularPercentIndicator(
                  percent: 0.5,
                  radius: 34.5,
                  lineWidth: 12,
                  animation: true,
                  animateFromLastPercent: true,
                  progressColor: AppColors.light.tertiary,
                  backgroundColor: AppColors.light.background,
                  center: const Text(
                    '50%',
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 16,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
                RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '2 / ',
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 18,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '4 GB',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      ],
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        letterSpacing: 0.0,
                      )),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
