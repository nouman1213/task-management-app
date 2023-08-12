import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_management_app/model/taskmodel.dart';
import 'package:task_management_app/screens/main_screen.dart';
import 'package:task_management_app/screens/taskDetails_screen.dart';

import '../components/tasktile.dart';
import '../constant/const.dart';
import '../controller/task/addTaskController.dart';
import 'addtask_screen.dart';

class AllTasksScreen extends StatefulWidget {
  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  final taskController = Get.put(AddTaskController());
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
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.to(() => MainScreen());
            },
            icon: Icon(Icons.arrow_back),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text('All Tasks'),
          // backgroundColor: Colors.amber[300],
        ),
        body: FutureBuilder(
          future: taskController.fetchAllTaskList(fkcoid: fkcoid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
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
                                        style: kTextStyleBoldBlack(16.0),
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
