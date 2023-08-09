import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/model/taskmodel.dart';

import '../components/button2.dart';
import '../constant/const.dart';
import '../controller/task/addTaskController.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  final AddTaskController addTaskController;

  TaskDetailScreen({required this.task, required this.addTaskController});

  void deleteTask() {
    addTaskController.removeTask(task);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Task Details', style: kTextStyleBoldWhite(18)),
        // backgroundColor: Colors.amber[300],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${task.title}',
              style: TextStyle(fontSize: 24),
            ),
            kVerticalSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRow(
                  color: Colors.blue.shade800,
                  label: task.startDate.toString(),
                  icon: Icons.calendar_month_sharp,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: Colors.blue.shade800),
                  ),
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                  ),
                ),
                CustomRow(
                  color: Colors.blue.shade800,
                  label: task.endDate.toString(),
                  icon: Icons.calendar_month_sharp,
                ),
              ],
            ),
            kVerticalSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => CustomRow(
                      color: Colors.blue.shade800,
                      label: 'Status: ${task.status}',
                      icon: task.status.value == 'Completed'
                          ? Icons.done
                          : Icons.incomplete_circle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomRow(
                    color: Colors.blue.shade800,
                    label: task.priority.toString(),
                    icon: Icons.low_priority,
                  ),
                ),
              ],
            ),
            kVerticalSpace(25),
            Text(
              'Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${task.details}',
              style: TextStyle(fontSize: 18),
            ),
            kVerticalSpace(50),
            CustomButton(
              label: 'Change Status',
              color: Colors.green.withOpacity(0.3),
              onTap: () {
                showChangeStatusDialog(task, addTaskController);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showChangeStatusDialog(Task task, AddTaskController addTaskController) {
    String? newStatus = task.status.value; // Set the initial value
    Get.dialog(
      AlertDialog(
        title: Text('Change Task Status'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('To Do'),
                  leading: Radio(
                    value: 'To Do',
                    groupValue: newStatus,
                    onChanged: (value) {
                      setState(() {
                        newStatus = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('In Progress'),
                  leading: Radio(
                    value: 'In Progress',
                    groupValue: newStatus,
                    onChanged: (value) {
                      setState(() {
                        newStatus = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Completed'),
                  leading: Radio(
                    value: 'Completed',
                    groupValue: newStatus,
                    onChanged: (value) {
                      setState(() {
                        newStatus = value;
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text('Update'),
            onPressed: () {
              if (newStatus != null) {
                addTaskController.updateTaskStatus(task, newStatus!);
              }
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow(
      {Key? key, required this.label, required this.icon, required this.color})
      : super(key: key);

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(width: 10),
        Text(label, style: kTextStyleBlack(18), softWrap: true),
      ],
    );
  }
}
