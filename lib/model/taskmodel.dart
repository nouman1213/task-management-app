import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Task {
  final String title;
  final String details;
  final String startDate;
  final String endDate;
  final String priority;
  final String assignedTo;
  RxString status;

  Task(
      {required this.title,
      required this.details,
      required this.startDate,
      required this.endDate,
      required this.priority,
      required this.assignedTo,
      required this.status});
}
