import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/screens/about_screen.dart';
import 'package:task_management_app/screens/addtask_screen.dart';
import 'package:task_management_app/screens/home_screen.dart';
import 'package:task_management_app/screens/auth_screen/login_screen.dart';
import 'package:task_management_app/screens/home_screen2.dart';
import 'package:task_management_app/screens/setting_screen.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // Inside your logout method
  void logout() {
    Get.dialog(
      AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.offAll(() => LoginScreen());
              Get.back();
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                currentAccountPictureSize: Size.square(80),
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                ),
                margin: EdgeInsets.zero,
                accountName: Text(
                  "Admin",
                  style: TextStyle(fontSize: 10.sp),
                ),
                accountEmail: Text(
                  "admin@gmail.com",
                  style: TextStyle(fontSize: 10.sp),
                ),
                // currentAccountPicture: Image.network(imageUrl),
                currentAccountPicture: CircleAvatar(
                  // backgroundColor: Color.fromARGB(255, 51, 80, 165),
                  // radius: 20,
                  child: Icon(Icons.person),
                ),
              ),
            ),
            // ListTile(
            //   onTap: () async {
            //     Navigator.pop(context);
            //     await Future.delayed(Duration(milliseconds: 1));
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => HomeScreen2()));
            //   },
            //   leading: Icon(
            //     CupertinoIcons.home,
            //     // color: Colors.white,
            //   ),
            //   title: Text(
            //     "Home",
            //     textScaleFactor: 1.1,
            //     style: TextStyle(
            //         // color: Colors.white,
            //         fontSize: 11.sp),
            //   ),
            // ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await Future.delayed(Duration(milliseconds: 1));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNewTaskScreen()));
              },
              leading: Icon(
                CupertinoIcons.today,
                // color: Colors.white,
              ),
              title: Text(
                "New Task",
                textScaleFactor: 1.1,
                style: TextStyle(

                    // color: Colors.white,
                    fontSize: 11.sp),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await Future.delayed(Duration(milliseconds: 1));
                Get.to(() => SettingsScreen(),
                    transition: Transition.leftToRightWithFade);
              },
              leading: Icon(
                CupertinoIcons.gear_solid,
                // color: Colors.white,
              ),
              title: Text(
                "Setting",
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontSize: 11.sp,
                  // color: Colors.white,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await Future.delayed(Duration(milliseconds: 1));
                Get.to(() => About_Screen(),
                    transition: Transition.leftToRightWithFade);
              },
              leading: Icon(
                CupertinoIcons.ant_circle,
                // color: Colors.white,
              ),
              title: Text(
                "About",
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontSize: 11.sp,
                  // color: Colors.white,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                logout();
              },
              leading: Icon(
                Icons.logout_rounded,
                // color: Colors.white,
              ),
              title: Text(
                "Logout",
                textScaleFactor: 1.1,
                style: TextStyle(
                    // color: Colors.white,
                    fontSize: 11.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
