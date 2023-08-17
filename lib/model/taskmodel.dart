class Task {
  final String title;
  final String details;
  final String startDate;
  final String endDate;
  final String priority;
  final String assignedTo;
  final String? assignedBy;
  final String? department;
  final String status;

  Task(
      {required this.title,
      required this.details,
      required this.startDate,
      required this.endDate,
      required this.priority,
      required this.assignedTo,
      required this.status,
      this.department,
      this.assignedBy});
}
