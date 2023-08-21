import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

import '../../model/get_tasklist_model.dart';
import '../../model/tasl_assignedToMe_model.dart';
import '../../notification_services.dart/notif_service.dart';
import '../menu_controller/user_controller.dart';

class AddTaskController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  RxList<GetTaskListModel> allTaskList = <GetTaskListModel>[].obs;
  RxList<GetTaskListModel> filterdTaskList = <GetTaskListModel>[].obs;
  RxList<TaskAssignedToMeModel> TaskAssignedMeList =
      <TaskAssignedToMeModel>[].obs;
  RxBool isTaskLoading = false.obs;
  List<GetTaskListModel> todoTaskList = [];
  List<GetTaskListModel> inProcessTaskList = [];
  List<GetTaskListModel> completedTaskList = [];

  Future<void> fetchFilterdTaskList({required fkcoid, required userid}) async {
    if (fkcoid == null) {
      print("fkCoid is null, cannot make API call");
      return;
    }

    try {
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/Task/GetTaskSplitList?coid=$fkcoid&usid=$userid"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        // Clear existing todoTaskList before updating it
        todoTaskList.clear();

        // Loop through tasks and filter tasks with status 'To do'
        for (var taskJson in jsonData) {
          GetTaskListModel task = GetTaskListModel.fromJson(taskJson);
          if (task.sTSNAME == 'To do') {
            todoTaskList.add(task);
          }
        }
        inProcessTaskList.clear();

        // Loop through tasks and filter tasks with status 'in process'
        for (var taskJson in jsonData) {
          GetTaskListModel task = GetTaskListModel.fromJson(taskJson);
          if (task.sTSNAME == 'In process') {
            inProcessTaskList.add(task);
          }
        }
        completedTaskList.clear();

        // Loop through tasks and filter tasks with status 'To do'
        for (var taskJson in jsonData) {
          GetTaskListModel task = GetTaskListModel.fromJson(taskJson);
          if (task.sTSNAME == 'Completed') {
            completedTaskList.add(task);
          }
        }
        allTaskList.value =
            jsonData.map((e) => GetTaskListModel.fromJson(e)).toList();
        print("api hit successfully${response.statusCode}");
      } else {
        throw Exception("Failed to load data from api");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<void> fetchAllTaskList({required fkcoid, required userid}) async {
    if (fkcoid == null) {
      print("fkCoid is null, cannot make API call");
      return;
    }

    try {
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/Task/GetTaskList?coid=$fkcoid&usid=$userid"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        allTaskList.value =
            jsonData.map((e) => GetTaskListModel.fromJson(e)).toList();
        print("api hit successfully${response.statusCode}");
      } else {
        throw Exception("Failed to load data from api");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  // fetch task assigen to me
  Future<void> fetchTaskAssignedMe({required fkcoid, required userid}) async {
    if (fkcoid == null) {
      print("fkCoid is null, cannot make API call");
      return;
    }

    try {
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/Task/AssignToMe?coid=$fkcoid&usid=$userid"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        TaskAssignedMeList.value =
            jsonData.map((e) => TaskAssignedToMeModel.fromJson(e)).toList();
        print("api hit successfully${response.statusCode}");
      } else {
        throw Exception("Failed to load data from api");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<void> insertTask({
    required fkcoid,
    required usid,
    required tittle,
    required details,
    required stdate,
    required endate,
    required assignto,
    required priority,
    required context,
    required tstatus,
    required compdt,
    required department,
  }) async {
    try {
      isTaskLoading.value = true;
      final response = await http.post(
        Uri.parse("https://erm.scarletsystems.com:132/Api/Task/InsertTask"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "FKCOID": fkcoid,
          "USID": usid,
          "TTITLE": tittle,
          "TDTL": details,
          "STDT": stdate,
          "ENDT": endate,
          "FKPRT": priority,
          "TOUSID": assignto,
          "TSTATUS": tstatus,
          "COMPDT": compdt,
          "FKDEPT": department,
        }),
      );

      if (response.statusCode == 200) {
        final userController = Get.find<UserController>();
        //After inserting the task successfully, schedule a notification for the assigned user
        if (assignto != -1) {
          bool isAssignedUserFound = userController.userList.any(
            (user) => user.uSID == assignto,
          );
          if (isAssignedUserFound) {
            await NotificationService().scheduleNotification(
              assignto,
              "New Task Assigned",
              "You have been assigned a new task: $tittle",
            );
          }
        }
        final box = GetStorage();
        fkcoid = box.read("fkCoid");

        print("Task inserted successfully");
        _clearController();
        GFToast.showToast('Task added successfully', context);
        fetchAllTaskList(fkcoid: fkcoid, userid: usid);

        isTaskLoading.value = false;
      } else if (response.statusCode == 400) {
        print('statuscode:${response.statusCode == 400}');
        GFToast.showToast(
            "Failed to add task ! error :${response.statusCode}", context,
            toastDuration: 4, backgroundColor: Colors.red.shade600);
        isTaskLoading.value = false;
        // Handle foreign key constraint error
      } else {
        isTaskLoading.value = false;

        throw Exception("Failed to insert task${response.statusCode}");
      }
    } catch (e) {
      isTaskLoading.value = false;

      print("Error: $e");
    }
  }

  _clearController() {
    titleController.clear();
    detailsController.clear();
    startDateController.clear();
    endDateController.clear();
  }
}
