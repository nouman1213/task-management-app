import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../components/keybord_hider.dart';
import '../components/roundbutton.dart';
import '../constant/const.dart';
import '../controller/menu_controller/priority_contoller.dart';
import '../controller/menu_controller/task_status_controller.dart';
import '../controller/menu_controller/user_controller.dart';
import '../controller/task/addTaskController.dart';
import 'package:getwidget/getwidget.dart';

class AddNewTaskScreen extends StatefulWidget {
  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final AddTaskController taskController = Get.put(AddTaskController());

  final priorityContoller = Get.put(PriorityContoller());

  final userContoller = Get.put(UserController());

  final statusContoller = Get.put(TaskStatusController());

  final _box = GetStorage();

  var email;

  var pass;
  var fkcoid;

// Date picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      taskController.startDateController.text = formattedDate;
    }
  }

// End date picker function
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      taskController.endDateController.text = formattedDate;
    }
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime currentDate = DateTime.now();

// Format the current date as "YYYY-MM-DD"
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);

    print(formattedDate);
    email = _box.read('loginId');
    pass = _box.read('uspass');
    fkcoid = _box.read('fkCoid');
    print('Stored Email: $email');
    print('Stored Password: $pass');
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Add New Task',
            style: kTextStyleBoldWhite(18),
          ),
          backgroundColor: Colors.blue[800],
        ),
        body: KeyboardHider(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(12.0),
            child: Form(
              key: _key,
              child: Obx(
                () => Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: taskController.titleController,
                          decoration: InputDecoration(
                            labelText: 'Task Title',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.amber.withOpacity(0.3),
                              ),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Enter name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          maxLines: 5,
                          controller: taskController.detailsController,
                          decoration: InputDecoration(
                            labelText: 'Task Details',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.amber.withOpacity(0.3),
                              ),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Enter details';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                controller: taskController.startDateController,
                                decoration: InputDecoration(
                                  labelText: 'Start Date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.blue.withOpacity(0.3),
                                    ),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Enter start date';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                controller: taskController.endDateController,
                                decoration: InputDecoration(
                                  labelText: 'End Date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.blue.withOpacity(0.3),
                                    ),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _selectEndDate(context);
                                    },
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Enter end date';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<int>(
                          validator: (v) {
                            if (v == null || v == -1) {
                              return 'Select Assign To';
                            } else {
                              return null;
                            }
                          },
                          value: userContoller.selectedAssignId,
                          items: [
                            DropdownMenuItem<int>(
                              value: -1,
                              child: Text(userContoller.selectedAssignTo),
                            ),
                            ...userContoller.userList.map((assignTo) {
                              return DropdownMenuItem<int>(
                                value: assignTo.uSID!,
                                child: Text(assignTo.lOGINID ?? ''),
                              );
                            }).toList(),
                          ],
                          onChanged: (value) {
                            userContoller.selectedAssignId = value!;
                            print(
                                " dropdownValue::::::${userContoller.selectedAssignId = value}");
                          },
                          decoration: InputDecoration(
                            labelText: 'Assign To',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<int>(
                          validator: (v) {
                            if (v == null || v == -1) {
                              return 'Select priority';
                            } else {
                              return null;
                            }
                          },
                          value: priorityContoller.selectedPriorityId,
                          items: [
                            DropdownMenuItem<int>(
                              value:
                                  -1, // -1 to represent "Please select priority"
                              child: Text(priorityContoller.selectedPriority),
                            ),
                            ...priorityContoller.priorityList.map((priority) {
                              return DropdownMenuItem<int>(
                                value: priority.pRTID!,
                                child: Text(priority.pRTNAME ?? ''),
                              );
                            }).toList(),
                          ],
                          onChanged: (value) {
                            priorityContoller.selectedPriorityId = value!;
                            print(
                                " dropdownValue::::::${priorityContoller.selectedPriorityId = value}");
                          },
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<int>(
                          validator: (v) {
                            if (v == null || v == -1) {
                              return 'Select Status';
                            } else {
                              return null;
                            }
                          },
                          value: statusContoller.selectedTaskStId,
                          items: [
                            DropdownMenuItem<int>(
                              value:
                                  -1, // -1 to represent "Please select priority"
                              child: Text(statusContoller.selectedTaskStatus),
                            ),
                            ...statusContoller.taskStatusList.map((status) {
                              return DropdownMenuItem<int>(
                                value: status.sTSID!,
                                child: Text(status.sTSNAME ?? ''),
                              );
                            }).toList(),
                          ],
                          onChanged: (value) {
                            statusContoller.selectedTaskStId = value!;
                            print(
                                " dropdownValue::::::${statusContoller.selectedTaskStId = value}");
                          },
                          decoration: InputDecoration(
                            labelText: 'Status',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        RoundButton(
                          title: "Add Task",
                          onTap: () {
                            if (_key.currentState!.validate()) {
                              taskController.insertTask(
                                fkcoid: fkcoid,
                                usid: userContoller.userList[0].uSID,
                                tittle: taskController.titleController.text,
                                details: taskController.detailsController.text,
                                stdate: taskController.startDateController.text,
                                endate: taskController.endDateController.text,
                                assignto: userContoller.selectedAssignId,
                                priority: priorityContoller.selectedPriorityId,
                                context: context,
                                compdt: formattedDate,
                                tstatus: statusContoller.selectedTaskStId,
                              );
                              priorityContoller.selectedPriorityId = -1;
                              userContoller.selectedAssignId = -1;
                              statusContoller.selectedTaskStId = -1;
                            }
                          },
                          backgroundColor: Colors.blue[800],
                          loading: false,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                    taskController.isTaskLoading.value
                        ? Center(child: CircularProgressIndicator.adaptive())
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
