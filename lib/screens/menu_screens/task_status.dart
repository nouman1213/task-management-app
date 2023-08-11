import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/components/roundbutton.dart';

import '../../constant/const.dart';
import '../../controller/menu_controller/task_status_controller.dart';

class TaskStatusScreen extends StatelessWidget {
  TaskStatusScreen({super.key});
  final statusController = Get.put(TaskStatusController());
  void _showAddTaskStatusDialog(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Task Status'),
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
                    await statusController.insertTaskStatus(
                        statusController.insertStatusController.text,
                        statusController.fkcoid);
                    statusController.fetchTaskStatusList();
                    statusController.isInsertingStatus.value = false;
                    statusController.insertStatusController.clear();

                    Navigator.of(context).pop();
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

  void _showUpdateTaskStatusDialog(BuildContext context, controller, stsId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Task Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
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
                  print("Inside onPressed callback");
                  print("Controller Text: ${controller.text}");
                  print("FKCOID: ${statusController.fkcoid}");
                  print("stsid: $stsId");

                  if (controller.text.isNotEmpty) {
                    print("Updating status...");

                    await statusController.updateTaskStatus(
                      stsId,
                      controller.text,
                      statusController.fkcoid,
                    );

                    statusController.fetchTaskStatusList();
                    statusController.isInsertingStatus.value = false;
                    controller.clear();

                    Navigator.of(context).pop();
                  }
                },
                child: Text('Update'),
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
          "Task Status List",
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
                  Obx(() => statusController.taskStatusList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            key: UniqueKey(),
                            itemCount: statusController.taskStatusList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final status =
                                  statusController.taskStatusList[index];
                              return GestureDetector(
                                onTap: () {
                                  if (status.sTSID != null) {
                                    print(status.sTSID);
                                  }
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(status.sTSNAME ?? "",
                                        style: kTextStyleBlack(18)),
                                    trailing: Container(
                                      width: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 40,
                                            child: IconButton(
                                              onPressed: () {
                                                statusController
                                                        .updateStatusController
                                                        .text =
                                                    status.sTSNAME.toString();
                                                _showUpdateTaskStatusDialog(
                                                    context,
                                                    statusController
                                                        .updateStatusController,
                                                    status.sTSID);
                                              },
                                              icon: Icon(Icons.edit,
                                                  color: Colors.green),
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            child: IconButton(
                                              onPressed: () {
                                                _showDeleteTaskStatusDialog(
                                                    context, status.sTSID);
                                              },
                                              icon: Icon(Icons.delete,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Expanded(child: Center(child: Text("No data found")))),
                  RoundButton(
                      width: 200,
                      backgroundColor: Colors.green.shade500,
                      title: "Add Task Status",
                      onTap: () {
                        _showAddTaskStatusDialog(
                          context,
                        );
                      })
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _showDeleteTaskStatusDialog(BuildContext context, int? stsid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AlertDialog(
              title: Text('Delete Company'),
              content:
                  Text('Are you sure you want to delete this task status?'),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    await statusController.deleteTaskStatus(stsid);
                    statusController.isInsertingStatus.value = true;
                    statusController.fetchTaskStatusList();
                    statusController.isInsertingStatus.value = false;

                    Navigator.of(context).pop();
                  },
                  child: Text('Delete'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
            Obx(() {
              if (statusController.isInsertingStatus.value) {
                return CircularProgressIndicator();
              } else {
                return SizedBox.shrink();
              }
            }),
          ],
        );
      },
    );
  }
}
