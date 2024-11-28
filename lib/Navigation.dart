import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gym_app/navigation_controller.dart';

class NavPage extends StatelessWidget {
  const NavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) => Scaffold(
        body: IndexedStack(
          index: controller.currentTap,
          children: controller.pages,
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 22, left: 12, right: 12),
          child: GNav(
            color: Colors.grey,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.all(16),
            gap: 8,
            selectedIndex: controller.currentTap,
            onTabChange: (index) {
              controller.goToPage(index);
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "home",
              ),
              GButton(
                icon: Icons.insert_chart,
                text: "Stats",
              ),
              GButton(
                icon: Icons.history,
                text: "History",
              ),
              GButton(
                icon: Icons.person_2,
                text: "Profile",
              ),
          ]),
        ),
      ),
      
    );
  }
}