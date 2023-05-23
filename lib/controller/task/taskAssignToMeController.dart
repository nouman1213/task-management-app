import 'package:get/get.dart';

import '../../model/taskmodel.dart';

class TaskAssignedToMeController extends GetxController {
  final RxList<Task> taskToAssignedMe = <Task>[
    Task(
      title: 'My Task',
      details: 'Task details',
      startDate: '2023-05-01',
      endDate: '2023-05-05',
      priority: 'High',
      assignedTo: 'me',
      status: 'To do'.obs,
    ),
  ].obs;

  addTaskToAssignedToMe(Task task) {
    taskToAssignedMe.add(task);
  }

  void removeTaskFromAssignedToMe(Task task) {
    taskToAssignedMe.remove(task);
  }
}
