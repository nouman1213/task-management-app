// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_management_app/components/tasktile.dart';

// import '../../constant/const.dart';
// import '../../controller/task/addTaskController.dart';
// import '../../model/taskmodel.dart';
// import '../taskDetails_screen.dart';

// class InProgressScreen extends StatelessWidget {
//   final AddTaskController addTaskController;

//   InProgressScreen({required this.addTaskController});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('In Progress Tasks'),
//       ),
//       body: Obx(
//         () => addTaskController.inProgressTasks.isEmpty
//             ? Center(
//                 child: Text(
//                   "No Task in Progress",
//                   style: kTextStyleBoldBlack(20.0),
//                 ),
//               )
//             : ListView.builder(
//                 itemCount: addTaskController.inProgressTasks.length,
//                 itemBuilder: (context, index) {
//                   Task task = addTaskController.inProgressTasks[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GestureDetector(
//                         onTap: () {
//                           Get.to(() => TaskDetailScreen(
//                               task: task,
//                               addTaskController: addTaskController));
//                         },
//                         child: TaskTile(task: task)),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }
