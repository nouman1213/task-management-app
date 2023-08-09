import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/components/roundbutton.dart';
import 'package:task_management_app/controller/menu_controller/priority_contoller.dart';

import '../../constant/const.dart';

class PirorityScreen extends StatelessWidget {
  PirorityScreen({super.key});
  final priorityContoller = Get.put(PriorityContoller());
  void _showAddPriorityDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Priority'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: priorityContoller.insertPriorityController,
                  decoration: InputDecoration(labelText: 'Priority Name'),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (priorityContoller.isInsertingPriority.value) {
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
                  if (priorityContoller
                      .insertPriorityController.text.isNotEmpty) {
                    await priorityContoller.insertPriority(
                        priorityContoller.insertPriorityController.text);
                    priorityContoller.insertPriorityController.clear();
                    Navigator.of(context).pop();
                    priorityContoller.fetchPriorityList();
                    priorityContoller.isInsertingPriority.value = false;
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
          "All Pirorities",
          style: kTextStyleWhite(18),
        ),
      ),
      body: FutureBuilder(
        future: priorityContoller.fetchPriorityList(),
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
                          itemCount: priorityContoller.priorityList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final priority =
                                priorityContoller.priorityList[index];
                            return Text(
                              priority.pRTNAME ?? '',
                              style: kTextStyleBlack(18),
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
                                title: "Add priority",
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
