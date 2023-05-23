import 'package:flutter/material.dart';
import 'package:task_management_app/components/tasktile.dart';
import 'package:task_management_app/model/taskmodel.dart';

class ToDoTaskScreen extends StatelessWidget {
  final List<Task> allTasks;
  final List<Task> assignedToMeTasks;

  ToDoTaskScreen({required this.allTasks, required this.assignedToMeTasks});

  @override
  Widget build(BuildContext context) {
    List<Task> mergedTasks = [...allTasks];

    for (Task task in assignedToMeTasks) {
      if (!mergedTasks.contains(task)) {
        mergedTasks.add(task);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('To Do Task'),
        backgroundColor: Colors.amber[300],
      ),
      body: ListView.builder(
        itemCount: mergedTasks.length,
        itemBuilder: (context, index) {
          final task = mergedTasks[index];
          return GestureDetector(
            onTap: () {
              // Get.to(() => TaskDetailScreen(
              //       task: task,
              //       addTaskController: null,
              //     ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskTile(
                task: task,
              ),
            ),
            // child: TaskCard(task: task),
          );
        },
      ),
    );
  }
}
