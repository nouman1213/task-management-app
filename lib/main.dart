import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/controller/task/addTaskController.dart';
import 'package:task_management_app/screens/home_screen.dart';

import 'controller/task/taskAssignToMeController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TaskAssignedToMeController());
  Get.put(AddTaskController());

  runApp(Sizer(builder: (context, orientation, deviceType) {
    return MyApp();
  }));
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // home: SplashScreen(),
      home: HomeScreen(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<TaskAssignedToMeController>(
            () => TaskAssignedToMeController());
      }),
    );
  }
}
