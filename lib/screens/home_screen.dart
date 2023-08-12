// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:sizer/sizer.dart';
// import 'package:task_management_app/screens/addtask_screen.dart';
// import 'package:task_management_app/screens/taskAssignedToMe.dart';

// import '../components/drawer.dart';
// import '../components/show_task_status.dart';
// import '../constant/const.dart';
// import '../controller/task/addTaskController.dart';
// import '../controller/task/taskAssignToMeController.dart';
// import '../model/taskmodel.dart';
// import 'allTask_screen.dart';

// class HomeScreen extends StatelessWidget {
//   final AddTaskController _addTaskController = Get.find();
//   final TaskAssignedToMeController _taskAssignedToMeController = Get.find();
//   String formatDate(DateTime dateTime) {
//     final formatter = DateFormat('dd MMM yyyy');
//     return formatter.format(dateTime);
//   }

//   String formatTime(DateTime dateTime) {
//     final formatter = DateFormat('hh:mm a');
//     return formatter.format(dateTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     DateTime currentDateTime = DateTime.now();
//     String formattedDate = formatDate(currentDateTime);
//     String formattedTime = formatTime(currentDateTime);

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(
//           'D A S H B O A R D',
//           style: GoogleFonts.abel(
//             textStyle: TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 16.sp,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.amber[300],
//       ),
//       drawer: MyDrawer(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(1.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '${showGreeting()}, dear user !',
//                 style: kTextStyleBoldGrey(22.0),
//               ),
//               // kVerticalSpace(1.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     formattedDate,
//                     style: kTextStyleBoldGrey(16.sp),
//                   ),
//                   Text(
//                     formattedTime,
//                     style: kTextStyleBoldGrey(16.sp),
//                   ),
//                 ],
//               ),
//               kVerticalSpace(1.h),
//               ShowTaskStatus(),
//               kVerticalSpace(1.h),
//               Center(
//                 child: SizedBox(
//                   width: 74.w,
//                   child: ElevatedButton.icon(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateColor.resolveWith(
//                         (states) => Colors.amber.shade200,
//                       ),
//                     ),
//                     onPressed: () {
//                       Get.to(() => AddNewTaskScreen());
//                     },
//                     icon: Icon(
//                       Icons.add,
//                       color: Colors.black,
//                     ),
//                     label: Text(
//                       "Create Task",
//                       style: kTextStyleBoldBlack(16.0),
//                     ),
//                   ),
//                 ),
//               ),
//               // kVerticalSpace(1.h),
//               SizedBox(
//                 height: 26.h,
//                 child: Padding(
//                   padding: EdgeInsets.all(1.h),
//                   child: GestureDetector(
//                     onTap: () {
//                       List<Task> allTasks =
//                           Get.find<AddTaskController>().allTasks.toList();
//                       List<Task> assignedTasks =
//                           Get.find<TaskAssignedToMeController>()
//                               .taskToAssignedMe
//                               .toList();
//                       Get.to(
//                         () => AllTasksScreen(),
//                       );
//                     },
//                     child: SizedBox(
//                       height: 10.h,
//                       width: double.infinity,
//                       child: Card(
//                         color: Colors.yellow[800],
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(1.h),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 Lottie.asset('assets/images/lists.json',
//                                     height: 14.h),
//                                 Text(
//                                   'All Tasks',
//                                   style: kTextStyleBoldWhite(24.0),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 26.h,
//                 child: Padding(
//                   padding: EdgeInsets.all(1.h),
//                   child: GestureDetector(
//                     onTap: () {
//                       Get.to(
//                         () => TaskAssignedToMeScreen(
//                           tasks: _taskAssignedToMeController.taskToAssignedMe,
//                         ),
//                       );
//                     },
//                     child: SizedBox(
//                       height: 10.h,
//                       width: double.infinity,
//                       child: Card(
//                         color: Colors.pink[800],
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Padding(
//                           padding: EdgeInsets.all(1.h),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 Lottie.asset(
//                                   'assets/images/list2.json',
//                                   height: 14.h,
//                                 ),
//                                 Text(
//                                   'Tasks Assigned To Me',
//                                   style: kTextStyleBoldWhite(24.0),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// // class HomeScreen extends StatelessWidget {
// //   final AddTaskController _addTaskController = Get.find();
// //   final TaskAssignedToMeController _taskAssignedToMeController = Get.find();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // backgroundColor: Colors.purple[600],
// //       appBar: AppBar(
// //         elevation: 0,
// //         title: Text(
// //           'D A S H B O A R D',
// //           style: GoogleFonts.abel(
// //             textStyle: TextStyle(
// //                 // color: Colors.white,
// //                 fontWeight: FontWeight.w600,
// //                 // height: 1.5,
// //                 fontSize: 16.sp),
// //           ),
// //         ),
// //         backgroundColor: Colors.amber[300],
// //       ),
// //       drawer: MyDrawer(),
// //       body: Padding(
// //         padding: const EdgeInsets.all(8.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.start,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               '${showGreeting()} ',
// //               style: kTextStyleBoldGrey(22.0),
// //             ),
// //             kVerticalSpace(10),
// //             ShowTaskStatus(),
// //             kVerticalSpace(10),
// //             Center(
// //               child: SizedBox(
// //                 width: 250,
// //                 child: ElevatedButton.icon(
// //                     style: ButtonStyle(
// //                       backgroundColor: MaterialStateColor.resolveWith(
// //                         (states) => Colors.amber.shade200,
// //                       ),
// //                     ),
// //                     onPressed: () {
// //                       Get.to(() => AddNewTaskScreen());
// //                     },
// //                     icon: Icon(
// //                       Icons.add,
// //                       color: Colors.black,
// //                     ),
// //                     label: Text(
// //                       "Create Task",
// //                       style: kTextStyleBoldBlack(16.0),
// //                     )),
// //               ),
// //             ),
// //             kVerticalSpace(10),
// //             Expanded(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: GestureDetector(
// //                   onTap: () {
// //                     List<Task> allTasks =
// //                         Get.find<AddTaskController>().allTasks.toList();
// //                     List<Task> assignedTasks =
// //                         Get.find<TaskAssignedToMeController>()
// //                             .taskToAssignedMe
// //                             .toList();
// //                     Get.to(
// //                       () => AllTasksScreen(
// //                           // allTasks: allTasks,
// //                           // assignedToMeTasks: assignedTasks,
// //                           ),
// //                     );
// //                   },
// //                   child: SizedBox(
// //                     height: 10.h,
// //                     width: double.infinity,
// //                     child: Card(
// //                       color: Colors.yellow[800],
// //                       elevation: 4,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Center(
// //                           child: Column(
// //                             children: [
// //                               Lottie.asset('assets/images/lists.json',
// //                                   height: 16.h),
// //                               Text(
// //                                 'All Tasks',
// //                                 style: kTextStyleBoldWhite(24.0),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             Expanded(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: GestureDetector(
// //                   onTap: () {
// //                     Get.to(
// //                       () => TaskAssignedToMeScreen(
// //                         tasks: _taskAssignedToMeController.taskToAssignedMe,
// //                       ),
// //                     );
// //                   },
// //                   child: SizedBox(
// //                     height: 10.h,
// //                     width: double.infinity,
// //                     child: Card(
// //                       color: Colors.pink[800],
// //                       elevation: 4,
// //                       shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(10)),
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Center(
// //                           child: Column(
// //                             children: [
// //                               Lottie.asset(
// //                                 'assets/images/list2.json',
// //                                 height: 16.h,
// //                               ),
// //                               Text(
// //                                 'Tasks Assigned To Me',
// //                                 style: kTextStyleBoldWhite(24.0),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
