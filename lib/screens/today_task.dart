import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/model/taskmodel.dart';
import 'package:task_management_app/screens/taskDetails_screen.dart';

import '../components/calender.dart';
import '../controller/task/addTaskController.dart';

class TodayTaskScreen extends StatefulWidget {
  @override
  State<TodayTaskScreen> createState() => _TodayTaskScreenState();
}

class _TodayTaskScreenState extends State<TodayTaskScreen> {
  DateTime selectedDate = DateTime.now();
  int currentDateSelectedIndex = 0;
  ScrollController scrollController = ScrollController();

  final AddTaskController addTaskController = Get.find<AddTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text("Today Task"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              child: Calendar(
                scrollController: scrollController,
                currentDateSelectedIndex: currentDateSelectedIndex,
                onDateSelected: (index) {
                  setState(() {
                    currentDateSelectedIndex = index;
                    selectedDate = DateTime.now().add(Duration(days: index));
                  });
                },
              ),
            ),
          ),
          Flexible(
            child: Obx(
              () {
                final List<Task> tasks = addTaskController.allTasks
                    .where((task) => isSameDay(
                        DateFormat('yyyy-MM-dd').parse(task.startDate),
                        selectedDate))
                    .toList();
                if (tasks.isEmpty) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'No tasks for today',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 12),
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Task task = tasks[index];

                      return GestureDetector(
                        onTap: () {
                          Get.to(() => TaskDetailScreen(
                              task: task,
                              addTaskController: addTaskController));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(task.title),
                            trailing: Text(task.startDate),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
