import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/screens/about_screen.dart';
import 'package:task_management_app/screens/addtask_screen.dart';
import 'package:task_management_app/screens/auth_screen/login_screen.dart';
import 'package:task_management_app/screens/menu_screens/task_status.dart';
import 'package:task_management_app/screens/setting_screen.dart';

import '../screens/menu_screens/task_priority.dart';
import '../screens/menu_screens/user_list.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final _box = GetStorage();
  var fkroll = '';
  var email = '';

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
              _box.remove("usid");
              _box.remove("loginId");
              _box.remove("uspass");
              _box.remove("fkRoll");
              _box.remove("fkCoid");

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
  void initState() {
    super.initState();
    fkroll = _box.read("fkRoll");
    email = _box.read("loginId");
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
                  fkroll,
                  style: TextStyle(fontSize: 10.sp),
                ),
                accountEmail: Text(
                  email,
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
            Visibility(
              visible: fkroll == "Admin",
              child: ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 1));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskPriorityScreen()));
                },
                leading: Icon(
                  CupertinoIcons.book,
                  // color: Colors.white,
                ),
                title: Text(
                  "Task Pirority",
                  textScaleFactor: 1.1,
                  style: TextStyle(

                      // color: Colors.white,
                      fontSize: 11.sp),
                ),
              ),
            ),
            Visibility(
              visible: fkroll == 'Admin',
              child: ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 1));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskStatusScreen()));
                },
                leading: Icon(
                  CupertinoIcons.book_fill,
                  // color: Colors.white,
                ),
                title: Text(
                  "Task Status",
                  textScaleFactor: 1.1,
                  style: TextStyle(

                      // color: Colors.white,
                      fontSize: 11.sp),
                ),
              ),
            ),
            Visibility(
              visible: fkroll == 'Admin',
              child: ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 1));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserListScreen()));
                },
                leading: Icon(
                  CupertinoIcons.person_2_square_stack,
                  // color: Colors.white,
                ),
                title: Text(
                  "Manage Users",
                  textScaleFactor: 1.1,
                  style: TextStyle(

                      // color: Colors.white,
                      fontSize: 11.sp),
                ),
              ),
            ),
            // ListTile(
            //   onTap: () async {
            //     Navigator.pop(context);
            //     await Future.delayed(Duration(milliseconds: 1));
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => CompanyListScreen()));
            //   },
            //   leading: Icon(
            //     CupertinoIcons.book_circle,
            //     // color: Colors.white,
            //   ),
            //   title: Text(
            //     "Company List",
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
