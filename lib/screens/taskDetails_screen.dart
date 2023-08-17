// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/model/task_details_model.dart';
import 'package:task_management_app/screens/main_screen.dart';

import '../components/button2.dart';
import '../constant/const.dart';
import '../controller/menu_controller/task_status_controller.dart';
import '../controller/task/task_detail_controller.dart';

class TaskDetailScreen extends StatefulWidget {
  int taskid;
  int fkcoid;
  TaskDetailScreen({
    Key? key,
    required this.taskid,
    required this.fkcoid,
  }) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final statusContoller = Get.put(TaskStatusController());

  final detailsController = Get.put(TaskDetailsController());

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

// Format the current date as "YYYY-MM-DD"
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,

        // leading: IconButton(
        //   onPressed: () {
        //     Get.to(() => AllTasksScreen());
        //   },
        //   icon: Icon(Icons.arrow_back),
        // ),
        // automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Task Details',
        ),
        // backgroundColor: Colors.amber[300],
      ),
      body: FutureBuilder<TaskDetailsListModel>(
        future: detailsController.fetchTaskDetails(
            fkcoid: widget.fkcoid, taskid: widget.taskid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final TaskDetailsListModel taskDetails = snapshot.data;
            String formatDate(String dateString) {
              final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
              final outputFormat = DateFormat("MMM dd, yyyy");

              final dateTime = inputFormat.parse(dateString);
              final formattedDate = outputFormat.format(dateTime);

              return formattedDate;
            }

            String formattedStartDate = formatDate(taskDetails.sTDT ?? '');
            String formattedEndDate = formatDate(taskDetails.eNDT ?? '');

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskDetails.tTITLE ?? '',
                    style: kTextStyleBoldBlack(context, 24),
                  ),
                  kVerticalSpace(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRow(
                        color: Colors.blue.shade800,
                        label: formattedStartDate,
                        icon: Icons.calendar_month_sharp,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(width: 1, color: Colors.blue.shade800),
                        ),
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                        ),
                      ),
                      CustomRow(
                        color: Colors.blue.shade800,
                        label: formattedEndDate,
                        icon: Icons.calendar_month_sharp,
                      ),
                    ],
                  ),
                  kVerticalSpace(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomRow(
                          color: Colors.blue.shade800,
                          label: taskDetails.sTSNAME.toString(),
                          icon: Icons.switch_access_shortcut_add_sharp,
                          //  task.status == 'Completed'
                          //     ? Icons.done
                          //     : Icons.incomplete_circle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: CustomRow(
                          color: Colors.blue.shade800,
                          label: taskDetails.pRTNAME.toString(),
                          icon: Icons.low_priority,
                        ),
                      ),
                    ],
                  ),
                  kVerticalSpace(25),
                  Text('Details', style: kTextStyleBoldBlack(context, 20.0)),
                  Text(
                    taskDetails.tDTL.toString(),
                    style: kTextStyleBlack(context, 16.0),
                  ),
                  kVerticalSpace(50),
                  CustomButton(
                    label: 'Change Status',
                    color: Colors.green.withOpacity(0.3),
                    onTap: () {
                      showChangeStatusDialog(
                        stid: taskDetails.tSTATUS ?? -1,
                        tstatus: statusContoller.selectedTaskStId,
                        compdate: formattedDate,
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void showChangeStatusDialog(
      {required stid, required tstatus, required compdate}) {
    Get.dialog(
      AlertDialog(
        title: Text('Change Task Status'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
                  validator: (v) {
                    if (v == null || v == -1) {
                      return 'Select Status';
                    } else {
                      return null;
                    }
                  },
                  value: stid,
                  items: [
                    DropdownMenuItem<int>(
                      value: -1, // -1 to represent "Please select status"
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
              ],
            );
          },
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Get.back();
            },
          ),
          Obx(
            () => TextButton(
              child: detailsController.isTaskLoading.value
                  ? CircularProgressIndicator() // Show loading indicator
                  : Text('Update'),
              onPressed: () async {
                await detailsController.updateTask(
                    taskid: widget.taskid,
                    fkcoid: widget.fkcoid,
                    tstatus: statusContoller.selectedTaskStId,
                    compdate: compdate);
                print('taskid::${widget.taskid}');
                print('fkcoid::${widget.fkcoid}');
                print('tstatus::${statusContoller.selectedTaskStId}');
                print('compdate::${widget.taskid}');

                Navigator.pop(context);
                await Future.delayed(Duration(milliseconds: 1));
                Get.to(() => MainScreen());
                GFToast.showToast('Task status update successfully', context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow(
      {Key? key, required this.label, required this.icon, required this.color})
      : super(key: key);

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(width: 10),
        Text(label, style: kTextStyleBlack(context, 18), softWrap: true),
      ],
    );
  }
}
