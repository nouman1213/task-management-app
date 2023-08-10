import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/components/roundbutton.dart';

import '../../constant/const.dart';
import '../../controller/menu_controller/task_status_controller.dart';

class TaskStatusScreen extends StatelessWidget {
  TaskStatusScreen({super.key});
  final statusController = Get.put(TaskStatusController());
  void _showAddPriorityDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: statusController.insertStatusController,
                  decoration: InputDecoration(labelText: 'Status Name'),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (statusController.isInsertingStatus.value) {
                    return CircularProgressIndicator();
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  if (statusController.insertStatusController.text.isNotEmpty) {
                    await statusController.insertStatus(
                        statusController.insertStatusController.text);
                    statusController.insertStatusController.clear();
                    Navigator.of(context).pop();
                    statusController.fetchTaskStatusList();
                    statusController.isInsertingStatus.value = false;
                  }
                },
                child: Text('Submit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Status",
          style: kTextStyleBoldWhite(18),
        ),
      ),
      body: FutureBuilder(
        future: statusController.fetchTaskStatusList(),
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
                  Obx(() => Expanded(
                        child: ListView.builder(
                          key: UniqueKey(),
                          itemCount: statusController.taskStatusList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final status =
                                statusController.taskStatusList[index];
                            return Card(
                              child: ListTile(
                                title: Text(status.sTSNAME ?? '',
                                    style: kTextStyleBlack(18)),
                              ),
                            );
                          },
                        ),
                      )),
                  SizedBox(
                    height: 120,
                    child: Row(
                      children: [
                        Expanded(
                            child: RoundButton(
                                backgroundColor: Colors.green.shade500,
                                title: "Add Status",
                                onTap: () {
                                  _showAddPriorityDialog(context);
                                })),
                        SizedBox(width: 10),
                        Expanded(
                            child: RoundButton(
                                backgroundColor: Colors.red.shade500,
                                title: "Delete",
                                onTap: () {})),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
