import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flex_app/views/now%20playing/now_playing_screen.dart';
import 'package:movie_flex_app/views/top%20rated/top_rated_screen.dart';

import '../../utils/color_theme.dart';
import '../../utils/constant_images.dart';
import 'bottom_nav_controller.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController =
        Get.put(BottomNavController(), permanent: false);
    return Scaffold(
        body: Obx(() => bottomNavController.tabIndex.value == 0
            ? const NowPlayingScreen()
            : const TopRatedScreen()
    ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
            backgroundColor: ColorTheme.primaryColor,
            currentIndex: bottomNavController.tabIndex.value,
            selectedLabelStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
            unselectedLabelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorTheme.lightGrey),
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(ConstantImages.nowPlayingInactive),
                activeIcon: Image.asset(
                  ConstantImages.nowPlayingActive,
                ),
                label: 'Now Playing',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(ConstantImages.topRatedInactive),
                activeIcon: Image.asset(ConstantImages.topRatedActive),
                label: 'Top Rated',
              ),
            ],
            onTap: (index){
              bottomNavController.changeTabIndex(index);
            },
          ),)
    );
  }
}