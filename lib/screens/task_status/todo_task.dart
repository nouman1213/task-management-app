import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/components/tasktile.dart';

import '../../constant/const.dart';
import '../../controller/task/addTaskController.dart';
import '../../model/taskmodel.dart';
import '../taskDetails_screen.dart';

class ToDoScreen extends StatelessWidget {
  final AddTaskController addTaskController;

  ToDoScreen({required this.addTaskController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do Tasks'),
      ),
      body: Obx(
        () => addTaskController.toDoTasks.isEmpty
            ? Center(
                child: Text(
                  "No To Do Tasks",
                  style: kTextStyleBoldBlack(20.0),
                ),
              )
            : ListView.builder(
                itemCount: addTaskController.toDoTasks.length,
                itemBuilder: (context, index) {
                  Task task = addTaskController.toDoTasks[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TaskTile(task: task),
                  );
                },
              ),
      ),
    );
  }
}
