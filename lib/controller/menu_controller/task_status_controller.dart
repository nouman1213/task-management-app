import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

import '../../model/status_list_model.dart';

class TaskStatusController extends GetxController {
  String selectedTaskStatus = 'Select Task Status';
  int selectedTaskStId = -1;
  RxList<GetStatusList> taskStatusList = <GetStatusList>[].obs;
  RxBool isInsertingStatus = false.obs;
  TextEditingController insertStatusController = TextEditingController();
  TextEditingController updateStatusController = TextEditingController();
  final box = GetStorage();
  var fkcoid;
  @override
  void onInit() {
    super.onInit();
    fkcoid = box.read("fkCoid");
    fetchTaskStatusList();
  }

  Future<void> fetchTaskStatusList() async {
    try {
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/TaskStatus/GetStatus?coid=$fkcoid"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        taskStatusList.value =
            jsonData.map((e) => GetStatusList.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load data from api");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  // insert priority method
  Future<void> insertTaskStatus(context, priorityName, fkcoid) async {
    try {
      isInsertingStatus.value = true;
      final response = await http.post(
        Uri.parse(
            "https://erm.scarletsystems.com:132/Api/TaskStatus/InsertTStatus"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "STSNAME": priorityName,
          "FKCOID": fkcoid,
        }),
      );

      if (response.statusCode == 200) {
        GFToast.showToast('status add successfully!', context,
            toastDuration: 4, backgroundColor: Colors.green.shade600);
        print("Priority inserted successfully");
      } else if (response.statusCode == 400) {
        print('statuscode:${response.statusCode == 400}');
        GFToast.showToast(
            'Unable to Delete Record Due to  Foreign key Constraint', context,
            toastDuration: 4, backgroundColor: Colors.red.shade600);
        isInsertingStatus.value = false;
        // Handle foreign key constraint error
      } else {
        isInsertingStatus.value = false;

        throw Exception("Failed to insert priority");
      }
    } catch (e) {
      isInsertingStatus.value = false;

      print("Error: $e");
    }
  }

  Future<void> deleteTaskStatus(BuildContext context, int? stsid) async {
    try {
      isInsertingStatus.value = true;
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/TaskStatus/DeleteTStatus?STSID=$stsid"));

      if (response.statusCode == 200) {
        GFToast.showToast('status delete successfully!', context,
            toastDuration: 4, backgroundColor: Colors.green.shade600);
        isInsertingStatus.value = false;
        // Delete was successful
        // final List<dynamic> jsonData = json.decode(response.body);
      } else if (response.statusCode == 400) {
        print('statuscode:${response.statusCode == 400}');
        GFToast.showToast(
            'Unable to Delete Record Due to  Foreign key Constraint', context,
            toastDuration: 4, backgroundColor: Colors.red.shade600);
        isInsertingStatus.value = false;
        // Handle foreign key constraint error
      } else {
        isInsertingStatus.value = false;
        // Handle other error cases
        print("Failed to delete data. Status code: ${response.statusCode}");
        throw Exception("Failed to delete data");
      }
    } catch (e) {
      isInsertingStatus.value = false;
      print("Error: $e");
      rethrow;
    }
  }

  Future<void> updateTaskStatus(context, stsid, stnam, fkcoid) async {
    try {
      isInsertingStatus.value = true;
      final response = await http.post(
        Uri.parse(
            "https://erm.scarletsystems.com:132/Api/TaskStatus/UpdateTStatus"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "STSID": stsid,
          "STSNAME": stnam,
          "FKCOID": fkcoid,
        }),
      );

      if (response.statusCode == 200) {
        GFToast.showToast('status update successfully!', context,
            toastDuration: 4, backgroundColor: Colors.green.shade600);
        print("Priority inserted successfully");
      } else if (response.statusCode == 400) {
        print('statuscode:${response.statusCode == 400}');
        GFToast.showToast('Unable to Insert Duplicate Record!', context,
            toastDuration: 4, backgroundColor: Colors.red.shade600);
        isInsertingStatus.value = false;
        // Handle foreign key constraint error
      } else {
        isInsertingStatus.value = false;

        throw Exception("Failed to insert priority");
      }
    } catch (e) {
      isInsertingStatus.value = false;

      print("Error: $e");
    }
  }
}
