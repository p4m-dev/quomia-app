import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/screens/buy_box_screen.dart';
import 'package:quomia/screens/user_profile_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/common/custom_bottom_app_bar.dart';
import 'package:quomia/widgets/home/box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.light.background,
      appBar: AppBar(
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
        title: Text('Quomia',
            style: TextStyle(
              fontFamily: 'DM Sans',
              color: AppColors.light.info,
              fontSize: 28,
            )),
        actions: [],
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BuyBoxScreen()));
        },
        tooltip: 'Cool FAB',
        shape: const CircleBorder(),
        child: Container(
          width: 56,
          height: 56,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: Alignment(0.0, 0.0),
              radius: 0.5,
              colors: [
                Color(0xFF00BF63),
                Color(0xFF377C45),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(onProfilePressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserProfileScreen()));
      }),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(
                data: 'I miei suggerimenti',
                fontSize: 24,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                            width: 120,
                            height: 100,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15, 10, 15, 15),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 55,
                                    height: 55,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      'https://picsum.photos/seed/649/600',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    'Laura Scolari',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              ),
              const Label(
                data: 'Per te',
                fontSize: 24,
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  const Box(),
                  const Box(),
                  const Box(),
                  const Box(),
                  const Box()
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
