import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/components/tasktile.dart';
import 'package:task_management_app/model/taskmodel.dart';
import 'package:task_management_app/screens/taskDetails_screen.dart';

import '../constant/const.dart';
import '../controller/task/addTaskController.dart';
import 'addtask_screen.dart';

class TaskAssignedToMeScreen extends StatelessWidget {
  final List<Task> tasks;

  TaskAssignedToMeScreen({required this.tasks});
  final AddTaskController _addTaskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Tasks Assigned To Me',
        ),
        // backgroundColor: Colors.amber[300],
      ),
      body: tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No tasks found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  kVerticalSpace(10),
                  SizedBox(
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
                ],
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return GestureDetector(
                    onTap: () {
                      Get.to(() => TaskDetailScreen(
                            task: task,
                            addTaskController: _addTaskController,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TaskTile(task: task),
                    ));
              },
            ),
    );
  }
}
