import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/screens/addtask_screen.dart';
import 'package:task_management_app/screens/taskAssignedToMe.dart';

import '../components/drawer.dart';
import '../components/show_task_status.dart';
import '../constant/const.dart';
import '../controller/task/addTaskController.dart';
import '../controller/task/taskAssignToMeController.dart';
import '../model/taskmodel.dart';
import 'allTask_screen.dart';

class HomeScreen extends StatelessWidget {
  final AddTaskController _addTaskController = Get.find();
  final TaskAssignedToMeController _taskAssignedToMeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple[600],
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'D A S H B O A R D',
          style: GoogleFonts.abel(
            textStyle: TextStyle(
                // color: Colors.white,
                fontWeight: FontWeight.w600,
                // height: 1.5,
                fontSize: 16.sp),
          ),
        ),
        backgroundColor: Colors.amber[300],
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${showGreeting()} ',
              style: kTextStyleBoldGrey(22.0),
            ),
            kVerticalSpace(10),
            ShowTaskStatus(),
            kVerticalSpace(10),
            Center(
              child: SizedBox(
                width: 250,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.amber.shade200,
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => AddNewTaskScreen());
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Create Task",
                      style: kTextStyleBoldBlack(16.0),
                    )),
              ),
            ),
            kVerticalSpace(10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    List<Task> allTasks =
                        Get.find<AddTaskController>().allTasks.toList();
                    List<Task> assignedTasks =
                        Get.find<TaskAssignedToMeController>()
                            .taskToAssignedMe
                            .toList();
                    Get.to(
                      () => AllTasksScreen(
                          // allTasks: allTasks,
                          // assignedToMeTasks: assignedTasks,
                          ),
                    );
                  },
                  child: SizedBox(
                    height: 10.h,
                    width: double.infinity,
                    child: Card(
                      color: Colors.yellow[800],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            children: [
                              Lottie.asset('assets/images/lists.json',
                                  height: 16.h),
                              Text(
                                'All Tasks',
                                style: kTextStyleBoldWhite(24.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => TaskAssignedToMeScreen(
                        tasks: _taskAssignedToMeController.taskToAssignedMe,
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 10.h,
                    width: double.infinity,
                    child: Card(
                      color: Colors.pink[800],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            children: [
                              Lottie.asset(
                                'assets/images/list2.json',
                                height: 16.h,
                              ),
                              Text(
                                'Tasks Assigned To Me',
                                style: kTextStyleBoldWhite(24.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //     floatingActionButton: FloatingActionButton(
      //       onPressed: () async {
      //         Get.to(() => AddNewTaskScreen());
      //       },
      //       child: Icon(Icons.add),
      //       backgroundColor: Colors.purple[600],
      //       foregroundColor: Colors.white,
      //       elevation: 4.0,
      //     ),
    );
  }
}
