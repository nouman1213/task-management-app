import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_management_app/components/tasktile.dart';
import 'package:task_management_app/model/taskmodel.dart';
import 'package:task_management_app/screens/taskDetails_screen.dart';

import '../constant/const.dart';
import '../controller/task/addTaskController.dart';
import 'addtask_screen.dart';

class TaskAssignedToMeScreen extends StatefulWidget {
  TaskAssignedToMeScreen();

  @override
  State<TaskAssignedToMeScreen> createState() => _TaskAssignedToMeScreenState();
}

class _TaskAssignedToMeScreenState extends State<TaskAssignedToMeScreen> {
  final taskController = Get.put(AddTaskController());
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Task Assign To Me'),
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        ),
        body: FutureBuilder(
          future: taskController.fetchAllTaskList(fkcoid: fkcoid, userid: usid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              // Sort allTaskList by start date before building the ListView
              taskController.allTaskList.sort((task1, task2) {
                DateTime startdate1 = DateTime.parse(task1.sTDT.toString());
                DateTime startdate2 = DateTime.parse(task2.sTDT.toString());
                return startdate1.compareTo(startdate2);
              });
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    taskController.allTaskList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: taskController.allTaskList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var task = taskController.allTaskList[index];
                                // Parse the date strings
                                DateTime startDate =
                                    DateTime.parse(task.sTDT.toString());
                                DateTime endDate =
                                    DateTime.parse(task.eNDT.toString());

                                return GestureDetector(
                                  onTap: () {
                                    print('taskId:::${task.tASKID}');
                                    print('fkcoid:::${fkcoid}');
                                    Get.to(() => TaskDetailScreen(
                                          taskid: task.tASKID!,
                                          fkcoid: fkcoid,
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: TaskTile(
                                      task: Task(
                                        title: task.tTITLE.toString(),
                                        assignedTo: task.lOGINID.toString(),
                                        details: task.tDTL.toString(),
                                        startDate:
                                            "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
                                        endDate:
                                            "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
                                        priority: task.pRTNAME ?? 'priority',
                                        status: task.sTSNAME ?? 'status',
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Column(
                            children: [
                              kVerticalSpace(100),
                              Center(
                                child: Text(
                                  'No tasks found',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              kVerticalSpace(10),
                              Center(
                                child: SizedBox(
                                  width: 150,
                                  child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                          (states) => Colors.green.shade400,
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
                                        style:
                                            kTextStyleBoldBlack(context, 16.0),
                                      )),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
