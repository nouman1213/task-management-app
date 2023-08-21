import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/model/taskmodel.dart';
import 'package:task_management_app/screens/taskDetails_screen.dart';

import '../components/calender.dart';
import '../controller/task/addTaskController.dart';
import '../model/get_tasklist_model.dart';

class TodayTaskScreen extends StatefulWidget {
  @override
  State<TodayTaskScreen> createState() => _TodayTaskScreenState();
}

class _TodayTaskScreenState extends State<TodayTaskScreen> {
  DateTime selectedDate = DateTime.now();
  int currentDateSelectedIndex = 0;
  ScrollController scrollController = ScrollController();

  final AddTaskController addTaskController = Get.find<AddTaskController>();
  var fkcoid;
  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    fkcoid = box.read("fkCoid");
  }

  @override
  Widget build(BuildContext context) {
    String formatDate(String dateString) {
      final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      final outputFormat = DateFormat("MMM dd, yyyy");

      final dateTime = inputFormat.parse(dateString);
      final formattedDate = outputFormat.format(dateTime);

      return formattedDate;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                final List<GetTaskListModel> tasks = addTaskController
                    .allTaskList
                    .where((task) => isSameDay(
                        DateFormat('yyyy-MM-dd').parse(task.sTDT!),
                        selectedDate))
                    .toList();
                if (tasks.isEmpty) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
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
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  );
                }

                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 12),
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final task = tasks[index];

                      return GestureDetector(
                        onTap: () {
                          Get.to(() => TaskDetailScreen(
                                fkcoid: fkcoid,
                                taskid: task.tASKID!,
                              ));
                        },
                        child: Card(
                          elevation: 2,
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 6),
                            title: Text(task.tTITLE!),
                            trailing: Text(formatDate(task.sTDT ?? "")),
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
