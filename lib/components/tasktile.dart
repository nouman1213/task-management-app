import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/model/taskmodel.dart';

import '../constant/const.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _customContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // "This is Title",
                      task.title.toString(),
                      style: kTextStyleBoldBlack(20),
                      softWrap: false,
                    ),
                    Text(
                      // "This is Title",
                      task.priority.toString(),
                      style: kTextStyleBlack(16),
                      softWrap: false,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Start Date",
                          style: kTextStyleBlack(14),
                          maxLines: 2,
                        ),
                        Text(
                          task.startDate.toString(),
                          // "details",
                          style: kTextStyleBlack(15),
                          maxLines: 2,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "End Date",
                          style: kTextStyleBlack(14),
                          maxLines: 2,
                        ),
                        Text(
                          task.endDate.toString(),
                          // "details",
                          style: kTextStyleBlack(15),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ],
                ),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                        // "assign to me",
                        task.details.toString(),
                        style: kTextStyleBlack(15)),
                  ),
                ),
              ],
            ),
            size: 0.8,
          ),
        ),
        const SizedBox(width: 2),
        _customContainer(
          child: Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.status.toString(),
                // "02-03-17",
                style: kTextStyleBoldBlack(20),
              ),
            ),
          ),
          size: 0.15,
        ),
      ],
    );
  }

  Widget _customContainer({required Widget child, required double size}) {
    return Container(
      height: 180,
      width: Get.width * size,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
