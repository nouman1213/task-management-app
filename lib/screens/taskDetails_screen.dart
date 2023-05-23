import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/model/taskmodel.dart';

import '../components/button2.dart';
import '../constant/const.dart';
import '../controller/task/addTaskController.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  final AddTaskController addTaskController;

  TaskDetailScreen({required this.task, required this.addTaskController});
  // final AddTaskController _addTaskController = Get.find();
  void deleteTask() {
    addTaskController.removeTask(task);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Details',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // kVerticalSpace(25),
            Text(
              '${task.title}',
              style: kTextStyleBlack(24),
            ),
            kVerticalSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRow(
                  color: Colors.amberAccent,
                  label: task.startDate.toString(),
                  icon: Icons.calendar_month_sharp,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: Colors.amber),
                  ),
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                  ),
                ),
                CustomRow(
                  color: Colors.amberAccent,
                  label: task.endDate.toString(),
                  icon: Icons.calendar_month_sharp,
                ),
              ],
            ),
            kVerticalSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRow(
                  color: Colors.amberAccent,
                  label: 'Status: ${task.status}',
                  icon: task.status == 'Done'
                      ? Icons.done
                      : Icons.incomplete_circle,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomRow(
                    color: Colors.amber,
                    label: task.priority.toString(),
                    icon: Icons.low_priority,
                  ),
                ),
              ],
            ),
            kVerticalSpace(25),
            Text(
              'Details',
              style: kTextStyleBoldBlack(24),
            ),
            Text(
              '${task.details}',
              style: kTextStyleBlack(18),
            ),
            kVerticalSpace(50),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'Done',
                    color: Colors.green.withOpacity(0.3),
                    onTap: () {
                      //final int id = task?.id as int;
                      // _taskController.updateTaskAsDone(id);
                      // _taskController.updateTaskStatus(id, 'Done');
                      Get.back();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    label: 'Delete',
                    color: Colors.red.withOpacity(0.3),
                    onTap: deleteTask,
                  ),
                ),
              ],
            ),
          ],
        ),
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
