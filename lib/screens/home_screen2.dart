import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:task_management_app/components/drawer.dart';

import '../constant/const.dart';
import '../controller/task/addTaskController.dart';
import '../controller/task/taskAssignToMeController.dart';
import '../model/taskmodel.dart';
import 'allTask_screen.dart';
import 'taskAssignedToMe.dart';
import 'task_status/completed_task.dart';
import 'task_status/inprogress_task.dart';
import 'task_status/todo_task.dart';

class HomeScreen2 extends StatelessWidget {
  HomeScreen2({super.key});
  final AddTaskController _addTaskController = Get.find();
  final TaskAssignedToMeController _assignMeController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kVerticalSpace(30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GFAvatar(
                    backgroundColor: Colors.blue.shade50,
                    radius: 30,
                    child: Icon(
                      CupertinoIcons.person,
                      size: 40,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User',
                        style: kTextStyleBoldBlack(24.0),
                      ),
                      Text(
                        'Project Manger',
                        style: kTextStyleBlack(16.0),
                      ),
                    ],
                  ),
                  kHorizontleSpace(50.0),
                  GFAvatar(
                    backgroundColor: Colors.blue.shade900,
                    child: IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      icon: Icon(Icons.menu),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              kVerticalSpace(20.0),
              TextField(
                decoration: InputDecoration(
                    hintText: 'search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30)),
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                    isDense: true),
              ),
              kVerticalSpace(10.0),
              Text(
                'Projects',
                style: kTextStyleBoldBlack(24.0),
              ),
              kVerticalSpace(5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AllTasksScreen());
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.green.shade900,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${_addTaskController.allTasks.length} Task',
                                style: kTextStyleWhite(16)),
                            Text('All Tasks', style: kTextStyleWhite(22)),
                            // Text('August 2023', style: kTextStyleWhite(16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      List<Task> assignedTasks =
                          Get.find<TaskAssignedToMeController>()
                              .taskToAssignedMe
                              .toList();
                      Get.to(() => TaskAssignedToMeScreen(
                            tasks: assignedTasks,
                          ));
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.red.shade900,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${_assignMeController.taskToAssignedMe.length} Task',
                                style: kTextStyleWhite(16)),
                            Text('Assign To Me', style: kTextStyleWhite(22)),
                            // Text('August 2023', style: kTextStyleWhite(16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              kVerticalSpace(10.0),
              Text(
                'My Tasks',
                style: kTextStyleBoldBlack(24.0),
              ),
              // kVerticalSpace(10.0),
              GFListTile(
                onTap: () {
                  Get.to(() => ToDoScreen(
                        addTaskController: _addTaskController,
                      ));
                },
                shadow: BoxShadow(),
                color: Colors.grey.shade50,
                avatar: GFAvatar(
                  backgroundColor: Colors.purple.shade800,
                  child: Icon(
                    Icons.assessment,
                    color: Colors.white,
                  ),
                ),
                titleText: 'Todo',
                subTitle: Text(
                    '${_addTaskController.allTasks.length} Task  - ${_addTaskController.allTasks.length} Started'),
              ),
              GFListTile(
                onTap: () {
                  Get.to(() => InProgressScreen(
                        addTaskController: _addTaskController,
                      ));
                },
                shadow: BoxShadow(),
                color: Colors.grey.shade50,
                avatar: GFAvatar(
                  backgroundColor: Colors.purple.shade800,
                  child: Icon(
                    Icons.incomplete_circle,
                    color: Colors.white,
                  ),
                ),
                titleText: 'On Progress',
                subTitle: Text(
                    '${_addTaskController.allTasks.length} Task  - ${_addTaskController.inProgressTasks.length} Progress'),
              ),
              GFListTile(
                onTap: () {
                  Get.to(() => CompletedScreen(
                        addTaskController: _addTaskController,
                      ));
                },
                shadow: BoxShadow(),
                color: Colors.grey.shade50,
                avatar: GFAvatar(
                  backgroundColor: Colors.purple.shade800,
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
                titleText: 'Done',
                subTitle: Text(
                    '${_addTaskController.allTasks.length} Task  - ${_addTaskController.completedTasks.length} Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}