// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_management_app/components/tasktile.dart';

// import '../../constant/const.dart';
// import '../../controller/task/addTaskController.dart';
// import '../../model/taskmodel.dart';

// class CompletedScreen extends StatelessWidget {
//   final AddTaskController addTaskController;

//   CompletedScreen({required this.addTaskController});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Completed Tasks'),
//       ),
//       body: Obx(
//         () => addTaskController.completedTasks.isEmpty
//             ? Center(
//                 child: Text(
//                   "No Completed Tasks",
//                   style: kTextStyleBoldBlack(20.0),
//                 ),
//               )
//             : ListView.builder(
//                 itemCount: addTaskController.completedTasks.length,
//                 itemBuilder: (context, index) {
//                   Task task = addTaskController.completedTasks[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TaskTile(task: task),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }
