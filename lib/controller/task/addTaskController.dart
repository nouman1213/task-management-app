import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/controller/task/taskAssignToMeController.dart';
import 'package:task_management_app/model/taskmodel.dart';

class AddTaskController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController assignToController = TextEditingController();
  final List<String> priorities = ['High', 'Medium', 'Low'];
  String selectedPriority = 'High';

  final RxList<Task> allTasks = <Task>[
    Task(
      title: 'Test',
      details:
          'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available',
      startDate: '2023-05-17',
      endDate: '2023-05-17',
      priority: 'High',
      assignedTo: '',
      status: "To do".obs,
    ),
  ].obs;

  final RxList<Task> mergedTasks = <Task>[].obs;
  final RxList<Task> toDoTasks = <Task>[].obs;
  final RxList<Task> inProgressTasks = <Task>[].obs;
  final RxList<Task> completedTasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    mergeTasks();
  }

//merge tassk
  void mergeTasks() {
    final assignedToMeTasks =
        Get.find<TaskAssignedToMeController>().taskToAssignedMe;
    mergedTasks.clear();
    toDoTasks.clear();

    mergedTasks.addAll(allTasks);

    for (Task task in assignedToMeTasks) {
      if (!mergedTasks.contains(task)) {
        mergedTasks.add(task);
      }
    }

    for (Task task in mergedTasks) {
      task.status.value = 'To Do'; // Set the status to 'To Do'
      toDoTasks.add(task);
    }
  }

//add task
  addTask() {
    Task newTask = Task(
        title: titleController.text.trim(),
        details: detailsController.text.trim(),
        startDate: startDateController.text.trim(),
        endDate: endDateController.text.trim(),
        priority: selectedPriority,
        assignedTo: assignToController.text.trim(),
        status: "To do".obs);
    allTasks.add(newTask);

    if (assignToController.text.trim().toLowerCase() == 'me') {
      Get.find<TaskAssignedToMeController>().addTaskToAssignedToMe(newTask);
    }

    mergeTasks();

    // Clear text field values...

    Get.back(result: newTask);
  }

//remove task here
  void removeTask(Task task) {
    allTasks.remove(task);
    Get.find<TaskAssignedToMeController>().removeTaskFromAssignedToMe(task);
    mergeTasks();
  }

// change status here

  void updateTaskStatus(Task task, String newStatus) {
    final currentStatus = task.status.value;

    // Remove the task from the current status list
    if (currentStatus == 'To Do') {
      toDoTasks.remove(task);
    } else if (currentStatus == 'In Progress') {
      inProgressTasks.remove(task);
    } else if (currentStatus == 'Completed') {
      completedTasks.remove(task);
    }

    // Update the task status
    task.status.value = newStatus;

    // Add the task to the new status list
    if (newStatus == 'To Do') {
      toDoTasks.add(task);
    } else if (newStatus == 'In Progress') {
      inProgressTasks.add(task);
    } else if (newStatus == 'Completed') {
      completedTasks.add(task);
    }
  }
}
