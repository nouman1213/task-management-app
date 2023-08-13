import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

import '../../model/get_tasklist_model.dart';

class AddTaskController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  RxList<GetTaskListModel> allTaskList = <GetTaskListModel>[].obs;
  RxBool isTaskLoading = false.obs;
  List<GetTaskListModel> todoTaskList = [];

  Future<void> fetchAllTaskList({required fkcoid}) async {
    if (fkcoid == null) {
      print("fkCoid is null, cannot make API call");
      return;
    }

    try {
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/Task/GetTaskList?coid=$fkcoid"));

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
          "COMPDT": compdt
        }),
      );

      if (response.statusCode == 200) {
        final box = GetStorage();
        fkcoid = box.read("fkCoid");

        print("Task inserted successfully");
        _clearController();
        GFToast.showToast('Task added successfully', context);
        fetchAllTaskList(fkcoid: null);

        isTaskLoading.value = false;
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
