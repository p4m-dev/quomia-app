import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/screens/user_profile_screen.dart';
import 'package:quomia/utils/app_colors.dart';
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
        onPressed: () {},
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
      bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 60,
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          elevation: 5,
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  tooltip: 'Open navigation menu',
                  icon: const Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 32,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  tooltip: 'Open navigation menu',
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 32,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  tooltip: 'Open navigation menu',
                  icon: const Icon(Icons.menu),
                  onPressed: () {},
                ),
                IconButton(
                  tooltip: 'Open navigation menu',
                  icon: const FaIcon(
                    FontAwesomeIcons.user,
                    color: Colors.black,
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserProfileScreen()));
                  },
                ),
              ])),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Box',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
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
    );
  }
}
