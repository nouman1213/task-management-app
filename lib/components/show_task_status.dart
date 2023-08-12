// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_management_app/components/task_status_container.dart';
// import 'package:task_management_app/controller/task/addTaskController.dart';
// import 'package:task_management_app/controller/task/taskAssignToMeController.dart';
// import 'package:task_management_app/screens/task_status/inprogress_task.dart';

// import '../constant/const.dart';
// import '../model/taskmodel.dart';
// import '../screens/task_status/completed_task.dart';

// class ShowTaskStatus extends StatelessWidget {
//   ShowTaskStatus({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final listStatus = TaskStatus.values.toList();
//     return SizedBox(
//       height: 160,
//       width: double.maxFinite,
//       child: ListView.builder(
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemCount: listStatus.length,
//         itemBuilder: (ctx, index) {
//           final status = listStatus[index];
//           return Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: InkWell(
//               onTap: () {
//                 List<Task> allTasks =
//                     Get.find<AddTaskController>().allTasks.toList();
//                 List<Task> assignedTasks =
//                     Get.find<TaskAssignedToMeController>()
//                         .taskToAssignedMe
//                         .toList();
//                 switch (index) {
//                   case 0:
//                     Get.to(() => ToDoScreen(
//                           addTaskController: Get.find<AddTaskController>(),
//                         ));
//                     break;
//                   case 1:
//                     // Code for index 1
//                     Get.to(() => InProgressScreen(
//                         addTaskController: Get.find<AddTaskController>()));
//                     // Add your logic here for when index is 1
//                     break;
//                   default:
//                     Get.to(() => CompletedScreen(
//                         addTaskController: Get.find<AddTaskController>()));
//                 }
//               },
//               borderRadius: BorderRadius.circular(60),
//               child: Center(child: TaskStatusContainer(status: status)),
//             ),
//           );
//         },
//       ),
//     );
//   }

 
// }
