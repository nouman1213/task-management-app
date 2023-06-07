import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/screens/setting_screen.dart';
import 'package:task_management_app/screens/today_task.dart';

import '../controller/main_controller.dart';
import 'addtask_screen.dart';
import 'package:getwidget/getwidget.dart';

import 'home_screen2.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final MainScreenController controller = Get.put(MainScreenController());

  final List<Widget> _pages = [
    HomeScreen2(),
    TodayTaskScreen(),
    AddNewTaskScreen(),
    Center(
      child: Text("message"),
    ),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,

      body: Obx(() => _pages[controller.selectedTab.value]),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(),
        child: Obx(() => BottomNavigationBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              showUnselectedLabels: true,
              currentIndex: controller.selectedTab.value,
              onTap: (index) => controller.changeTab(index),
              selectedItemColor: Colors.blue.shade900,
              unselectedItemColor: Colors.grey,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.assessment), label: "Today"),
                BottomNavigationBarItem(
                    icon: GFAvatar(
                        child: Icon(
                      Icons.add,
                      size: 30,
                    )),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat), label: "Message"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
              ],
            )),
      ),
    );
  }
}
