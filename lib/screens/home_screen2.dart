import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:task_management_app/components/drawer.dart';

import '../constant/const.dart';
import '../controller/task/addTaskController.dart';
import '../controller/task/taskAssignToMeController.dart';
import '../model/get_tasklist_model.dart';
import '../model/taskmodel.dart';
import 'allTask_screen.dart';
import 'taskAssignedToMe.dart';
import 'task_status/completed_task.dart';
import 'task_status/inprogress_task.dart';
import 'task_status/todo_task.dart';

class HomeScreen2 extends StatefulWidget {
  HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final AddTaskController taskController = Get.put(AddTaskController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var fkcoid;
  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    fkcoid = box.read("fkCoid");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: FutureBuilder(
        future: taskController.fetchAllTaskList(
            fkcoid: fkcoid), // Initialize AddTaskController
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
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
                                  Text(
                                      '${taskController.allTaskList.length} Task',
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
                                  Text('0 Task', style: kTextStyleWhite(16)),
                                  Text('Assign To Me',
                                      style: kTextStyleWhite(22)),
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
                        Get.to(() => ToDoScreen());
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
                          '${taskController.todoTaskList.length} Task  - 0 Started'),
                    ),
                    GFListTile(
                      onTap: () {
                        // Get.to(() => InProgressScreen(
                        //       addTaskController: _addTaskController,
                        //     ));
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
                      subTitle: Text('0 Task  - 0 Progress'),
                    ),
                    GFListTile(
                      onTap: () {
                        // Get.to(() => CompletedScreen(
                        //       addTaskController: _addTaskController,
                        //     ));
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
                      subTitle: Text('0 Task  - 0 Done'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
