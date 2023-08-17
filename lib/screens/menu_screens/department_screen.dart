import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/components/roundbutton.dart';
import 'package:task_management_app/controller/menu_controller/department_controller.dart';

import '../../constant/const.dart';

class DepartmentScreen extends StatelessWidget {
  DepartmentScreen({super.key});
  final departmentController = Get.put(DepartmentContoller());
  void _showAddDepartmentDialog(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Task Department'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: departmentController.insertDepartmentController,
                  decoration: InputDecoration(labelText: 'Department Name'),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (departmentController.isInsertingDepartment.value) {
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
                  if (departmentController
                      .insertDepartmentController.text.isNotEmpty) {
                    await departmentController.insertDepartment(
                        context,
                        departmentController.insertDepartmentController.text,
                        departmentController.fkcoid);
                    departmentController.fetchDepartmentList();
                    departmentController.isInsertingDepartment.value = false;
                    departmentController.insertDepartmentController.clear();

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

  void _showUpdateDepartmentDialog(BuildContext context, controller, dprtId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Task Department'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(labelText: 'Department Name'),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (departmentController.isInsertingDepartment.value) {
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
                  print("FKCOID: ${departmentController.fkcoid}");
                  print("DPRTID: $dprtId");

                  if (controller.text.isNotEmpty) {
                    print("Updating priority...");

                    await departmentController.updateDepartment(context,
                        controller.text, departmentController.fkcoid, dprtId);

                    print("Priority update completed.");

                    departmentController.fetchDepartmentList();
                    departmentController.isInsertingDepartment.value = false;
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
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        title: Text(
          "Task Department List",
          style: kTextStyleBoldWhite(context, 18),
        ),
      ),
      body: FutureBuilder(
        future: departmentController.fetchDepartmentList(),
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
                  Obx(() => departmentController.departmentList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            key: UniqueKey(),
                            itemCount:
                                departmentController.departmentList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final department =
                                  departmentController.departmentList[index];
                              return GestureDetector(
                                onTap: () {
                                  if (department.dPID != null) {
                                    print(department.dPID);
                                  }
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(department.dPNAME ?? "",
                                        style: kTextStyleBlack(context, 18)),
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
                                                departmentController
                                                        .updateDepartmentController
                                                        .text =
                                                    department.dPNAME
                                                        .toString();
                                                _showUpdateDepartmentDialog(
                                                    context,
                                                    departmentController
                                                        .updateDepartmentController,
                                                    department.dPID);
                                              },
                                              icon: Icon(Icons.edit,
                                                  color: Colors.green),
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            child: IconButton(
                                              onPressed: () {
                                                _showDeleteDepartmentDialog(
                                                    context, department.dPID);
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
                      title: "Add Task Department",
                      onTap: () {
                        _showAddDepartmentDialog(
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

  void _showDeleteDepartmentDialog(BuildContext context, int? dprtId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AlertDialog(
              title: Text('Delete Department'),
              content: Text('Are you sure you want to delete this department?'),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    await departmentController.deleteDepartment(
                        context, dprtId);
                    departmentController.isInsertingDepartment.value = true;
                    departmentController.fetchDepartmentList();
                    departmentController.isInsertingDepartment.value = false;

                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Delete',
                  ),
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
              if (departmentController.isInsertingDepartment.value) {
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
