import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/components/roundbutton.dart';

import '../../constant/const.dart';
import '../../controller/menu_controller/priority_contoller.dart';

class TaskPriorityScreen extends StatelessWidget {
  TaskPriorityScreen({super.key});
  final priorityController = Get.put(PriorityContoller());
  void _showAddPriorityDialog(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Task Prirority'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: priorityController.insertPriorityController,
                  decoration: InputDecoration(labelText: 'Priority Name'),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (priorityController.isInsertingPriority.value) {
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
                  if (priorityController
                      .insertPriorityController.text.isNotEmpty) {
                    await priorityController.insertPriority(
                        priorityController.insertPriorityController.text,
                        priorityController.fkcoid);
                    priorityController.fetchPriorityList();
                    priorityController.isInsertingPriority.value = false;
                    priorityController.insertPriorityController.clear();

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

  void _showUpdatePriorityDialog(BuildContext context, controller, prtId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Task Prirority'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(labelText: 'Priority Name'),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (priorityController.isInsertingPriority.value) {
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
                  print("FKCOID: ${priorityController.fkcoid}");
                  print("PRTID: $prtId");

                  if (controller.text.isNotEmpty) {
                    print("Updating priority...");

                    await priorityController.updatePriority(
                        controller.text, priorityController.fkcoid, prtId);

                    print("Priority update completed.");

                    priorityController.fetchPriorityList();
                    priorityController.isInsertingPriority.value = false;
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
          "Task Priority List",
          style: kTextStyleBoldWhite(18),
        ),
      ),
      body: FutureBuilder(
        future: priorityController.fetchPriorityList(),
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
                  Obx(() => priorityController.priorityList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            key: UniqueKey(),
                            itemCount: priorityController.priorityList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final priority =
                                  priorityController.priorityList[index];
                              return GestureDetector(
                                onTap: () {
                                  if (priority.pRTID != null) {
                                    print(priority.pRTID);
                                  }
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(priority.pRTNAME ?? "",
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
                                                priorityController
                                                        .updatePriorityController
                                                        .text =
                                                    priority.pRTNAME.toString();
                                                _showUpdatePriorityDialog(
                                                    context,
                                                    priorityController
                                                        .updatePriorityController,
                                                    priority.pRTID);
                                              },
                                              icon: Icon(Icons.edit,
                                                  color: Colors.green),
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            child: IconButton(
                                              onPressed: () {
                                                _showDeletePriorityDialog(
                                                    context, priority.pRTID);
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
                      title: "Add Task Priority",
                      onTap: () {
                        _showAddPriorityDialog(
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

  void _showDeletePriorityDialog(BuildContext context, int? prtId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AlertDialog(
              title: Text('Delete Company'),
              content: Text('Are you sure you want to delete this priority?'),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    await priorityController.deletePriority(prtId);
                    priorityController.isInsertingPriority.value = true;
                    priorityController.fetchPriorityList();
                    priorityController.isInsertingPriority.value = false;

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
              if (priorityController.isInsertingPriority.value) {
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
