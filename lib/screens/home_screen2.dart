import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:task_management_app/components/drawer.dart';

import '../constant/const.dart';
import '../controller/menu_controller/user_controller.dart';
import '../controller/task/addTaskController.dart';
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
  var usid;
  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    fkcoid = box.read("fkCoid");
    usid = box.read("usid");
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    taskController.fetchTaskAssignedMe(fkcoid: fkcoid, userid: usid);

    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: FutureBuilder<void>(
        future: Future.wait([
          taskController.fetchAllTaskList(fkcoid: fkcoid, userid: usid),
          taskController.fetchTaskAssignedMe(fkcoid: fkcoid, userid: usid),
          taskController.fetchFilterdTaskList(fkcoid: fkcoid, userid: usid),
        ]),
        // Initialize AddTaskController
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
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          radius: 30,
                          child: Icon(
                            CupertinoIcons.person,
                            color: Theme.of(context).colorScheme.primary,
                            size: 40,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Projects',
                              style: kTextStyleBoldBlack(context, 24.0),
                            ),
                            Text(
                              ' Management',
                              style: kTextStyleBoldBlack(context, 16.0),
                            ),
                          ],
                        ),
                        kHorizontleSpace(50.0),
                        GFAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          child: IconButton(
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            icon: Icon(Icons.menu),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    kVerticalSpace(20.0),
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          hintText: 'search...',
                          hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                          fillColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          filled: true,
                          isDense: true),
                    ),
                    kVerticalSpace(10.0),
                    Text(
                      'Projects',
                      style: kTextStyleBoldBlack(context, 24.0),
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
                                color: Theme.of(context).colorScheme.tertiary,
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      '${taskController.allTaskList.length} Task',
                                      style: kTextStyleWhite(context, 16)),
                                  Text('All Tasks',
                                      style: kTextStyleWhite(context, 22)),
                                  // Text('August 2023', style: kTextStyleWhite(16)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => TaskAssignedToMeScreen());
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error,
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      '${taskController.TaskAssignedMeList.length} Task',
                                      style: kTextStyleWhite(context, 16)),
                                  Text('Assign To Me',
                                      style: kTextStyleWhite(context, 22)),
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
                      style: kTextStyleBoldBlack(context, 24.0),
                    ),
                    // kVerticalSpace(10.0),
                    GFListTile(
                      onTap: () {
                        Get.to(() => ToDoScreen());
                      },
                      shadow: BoxShadow(),
                      color: Theme.of(context).colorScheme.onSecondary,
                      avatar: GFAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceTint,
                        child: Icon(
                          Icons.assessment,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      titleText: 'Todo Task',
                      subTitle: Text(
                        '${taskController.todoTaskList.length} Task',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    GFListTile(
                      onTap: () {
                        Get.to(() => InProgressScreen());
                      },
                      shadow: BoxShadow(),
                      color: Theme.of(context).colorScheme.onSecondary,
                      avatar: GFAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceTint,
                        child: Icon(
                          Icons.incomplete_circle,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      titleText: 'In Process Task',
                      subTitle: Text(
                        '${taskController.inProcessTaskList.length} Task',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    GFListTile(
                      onTap: () {
                        Get.to(() => CompletedScreen());
                      },
                      shadow: BoxShadow(),
                      color: Theme.of(context).colorScheme.onSecondary,
                      avatar: GFAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceTint,
                        child: Icon(
                          Icons.done,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      titleText: 'Completed Task',
                      subTitle: Text(
                        '${taskController.completedTaskList.length} Task',
                        style: TextStyle(color: Colors.black54),
                      ),
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
