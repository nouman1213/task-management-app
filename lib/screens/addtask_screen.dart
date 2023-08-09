import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../components/roundbutton.dart';
import '../controller/menu_controller/priority_contoller.dart';
import '../controller/task/addTaskController.dart';
import 'package:getwidget/getwidget.dart';

class AddNewTaskScreen extends StatelessWidget {
  final AddTaskController _addTaskController = Get.put(AddTaskController());
  final priorityContoller = Get.put(PriorityContoller());

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
      _addTaskController.startDateController.text = formattedDate;
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
      _addTaskController.endDateController.text = formattedDate;
    }
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Add New Task',
          style: GoogleFonts.abel(
            textStyle: TextStyle(
                // color: Colors.white,
                fontWeight: FontWeight.w600,
                // height: 1.5,
                fontSize: 16.sp),
          ),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.done,
                controller: _addTaskController.titleController,
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
                controller: _addTaskController.detailsController,
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
                      controller: _addTaskController.startDateController,
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
                      controller: _addTaskController.endDateController,
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
              TextField(
                textInputAction: TextInputAction.done,
                controller: _addTaskController.assignToController,
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
                    value: -1, // -1 to represent "Please select priority"
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
                      " dropdownValue::::::${priorityContoller.selectedPriorityId = value!}");
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
              SizedBox(height: 30),
              RoundButton(
                title: "Add Task",
                onTap: () {
                  if (_key.currentState!.validate()) {
                    _addTaskController.addTask();
                    GFToast.showToast('Task added successfully', context);
                  }
                },
                backgroundColor: Colors.blue[800],
                loading: false,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
