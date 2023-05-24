// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';

// import '../components/roundbutton.dart';
// import '../model/taskmodel.dart';

// class AddTaskScreen extends StatelessWidget {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController detailsController = TextEditingController();
//   final TextEditingController startDateController = TextEditingController();
//   final TextEditingController endDateController = TextEditingController();
//   final TextEditingController assignToController = TextEditingController();
//   final List<String> priorities = ['High', 'Medium', 'Low'];
//   String selectedPriority = 'High';

//   void addTask() {
//     Task newTask = Task(
//       title: titleController.text.trim(),
//       details: detailsController.text.trim(),
//       startDate: startDateController.text.trim(),
//       endDate: endDateController.text.trim(),
//       priority: selectedPriority,
//       assignedTo: assignToController.text.trim(),
//     );

//     // Close the add task screen and pass the new task back to the previous screen
//     Get.back(result: newTask);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Add New Task',
//           style: GoogleFonts.abel(
//             textStyle: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//                 // height: 1.5,
//                 fontSize: 16.sp),
//           ),
//         ),
//         backgroundColor: Colors.purple[600],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(labelText: 'Task Title'),
//             ),
//             TextField(
//               controller: detailsController,
//               decoration: InputDecoration(labelText: 'Task Details'),
//             ),
//             TextField(
//               controller: startDateController,
//               decoration: InputDecoration(labelText: 'Start Date'),
//             ),
//             TextField(
//               controller: endDateController,
//               decoration: InputDecoration(labelText: 'End Date'),
//             ),
//             TextField(
//               controller: assignToController,
//               decoration: InputDecoration(labelText: 'Assign To'),
//             ),
//             DropdownButtonFormField(
//               value: selectedPriority,
//               items: priorities.map((priority) {
//                 return DropdownMenuItem(
//                   value: priority,
//                   child: Text(priority),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 selectedPriority = value.toString();
//               },
//               decoration: InputDecoration(labelText: 'Priority'),
//             ),
//             SizedBox(height: 30),
//             RoundButton(
//               title: "Add Task",
//               onTap: addTask,
//               backgroundColor: Colors.purple[600],
//               loading: false,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../components/roundbutton.dart';
import '../controller/task/addTaskController.dart';

class AddNewTaskScreen extends StatelessWidget {
  final AddTaskController _addTaskController = Get.put(AddTaskController());
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
        backgroundColor: Colors.amber[300],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
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
            ),
            SizedBox(height: 20),
            TextField(
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
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _addTaskController.startDateController,
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.amber.withOpacity(0.3),
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  child: TextField(
                    controller: _addTaskController.endDateController,
                    decoration: InputDecoration(
                      labelText: 'End Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.amber.withOpacity(0.3),
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _selectEndDate(context);
                        },
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _addTaskController.assignToController,
              decoration: InputDecoration(
                labelText: 'Assign To',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.amber.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              value: _addTaskController.selectedPriority,
              items: _addTaskController.priorities.map((priority) {
                return DropdownMenuItem(
                  value: priority,
                  child: Text(priority),
                );
              }).toList(),
              onChanged: (value) {
                _addTaskController.selectedPriority = value.toString();
              },
              decoration: InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.amber.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            RoundButton(
              title: "Add Task",
              onTap: _addTaskController.addTask,
              backgroundColor: Colors.amber[300],
              loading: false,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
