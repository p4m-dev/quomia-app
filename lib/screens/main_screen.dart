import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/screens/buy_box_screen.dart';
import 'package:quomia/screens/home_screen.dart';
import 'package:quomia/screens/user_profile_screen.dart';
import 'package:quomia/utils/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const BuyBoxScreen(),
    const UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(32.0)),
          child: BottomNavigationBar(
            backgroundColor: AppColors.light.primaryBackground,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.light.tertiary,
            unselectedItemColor: AppColors.light.primaryText,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.hourglass,
                  size: 18.0,
                ),
                label: 'Box',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profilo',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
