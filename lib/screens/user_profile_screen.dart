import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/http/timer_http.dart';
import 'package:quomia/models/crypto/balance.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/user/chips_choice.dart';
import 'package:quomia/widgets/user/crypto_stats.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends State<UserProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  Balance? _cryptoBalance;

  final HttpTimerService httpTimerService = HttpTimerService();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onTabSelected() {
    _fetchCryptoBalance();
  }

  void onTabReselected() {
    print('Test');
  }

  Future<void> _fetchCryptoBalance() async {
    try {
      final response = await httpTimerService.fetchCryptoBalance();
      setState(() {
        _cryptoBalance = response;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
                        buildTopProfile(),
                        const Gap(height: 10.0),
                        const Gap(height: 10.0),
                        const Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Text('Statistiche',
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 20,
                              )),
                        ),
                        const Gap(height: 10.0),
                        CryptoStats(
                          isLoading: _isLoading,
                          cryptoBalance: _cryptoBalance,
                        ),
                        const Gap(height: 10.0),
                        const Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Text('I tuoi Box',
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 20,
                              )),
                        ),
                        const ChoiceChips(),
                        const SizedBox(
                          height: 10.0,
                        ),
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

  Material buildTopProfile() {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
          width: double.infinity,
          height: 270,
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          child: Text(
                            'SM',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ), //Text
                        ),
                        buildItems('Box', '78', () {
                          print('res');
                        }),
                        buildItems('Timers', '100', () {}),
                        buildItems('Chi segui', '20', () {}),
                      ],
                    ),
                    const Gap(height: 10.0),
                    const Text(
                      'Samuel Maggio',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(40, 40),
                                backgroundColor: AppColors.light.tertiary,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26))),
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            child: const Text(
                              "Modifica profilo",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(40, 40),
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
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ))
                      ],
                    ),
                  ]))),
    );
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
}
