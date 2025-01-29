import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/theme/palette.dart';

class CustomBottomAppBar extends StatelessWidget {
  final VoidCallback? onHomePressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onProfilePressed;

  const CustomBottomAppBar({
    super.key,
    this.onHomePressed,
    this.onSearchPressed,
    this.onMenuPressed,
    this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      elevation: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            tooltip: 'Home',
            icon: Icon(
              Icons.home,
              color: AppColors.light.primaryText,
              size: 32,
            ),
            onPressed: onHomePressed,
          ),
          IconButton(
            tooltip: 'Search',
            icon: Icon(
              Icons.search,
              color: AppColors.light.primaryText,
              size: 32,
            ),
            onPressed: onSearchPressed,
          ),
          IconButton(
            tooltip: 'Menu',
            icon: const Icon(Icons.menu),
            onPressed: onMenuPressed,
          ),
          IconButton(
            tooltip: 'Profile',
            icon: FaIcon(
              FontAwesomeIcons.user,
              color: AppColors.light.primaryText,
              size: 24,
            ),
            onPressed: onProfilePressed,
          ),
        ],
      ),
    );
  }
}
