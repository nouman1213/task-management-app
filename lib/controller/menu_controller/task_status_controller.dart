import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  Future<void> insertTaskStatus(priorityName, fkcoid) async {
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
        print("Priority inserted successfully");
      } else {
        throw Exception("Failed to insert priority");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      // Set loading state back to false
      isInsertingStatus.value = false;
    }
  }

  Future<void> deleteTaskStatus(int? stsid) async {
    try {
      isInsertingStatus.value = true;
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/TaskStatus/DeleteTStatus?STSID=$stsid"));

      if (response.statusCode == 200) {
        isInsertingStatus.value = false;

        // final List<dynamic> jsonData = json.decode(response.body);
      } else {
        isInsertingStatus.value = false;

        print("Failed to delete data. Status code: ${response.statusCode}");
        throw Exception("Failed to delete data");
      }
    } catch (e) {
      isInsertingStatus.value = false;

      print("Error: $e");
      rethrow;
    }
  }

  Future<void> updateTaskStatus(stsid, stnam, fkcoid) async {
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
        print("Priority inserted successfully");
      } else {
        throw Exception("Failed to insert priority");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      // Set loading state back to false
      isInsertingStatus.value = false;
    }
  }
}
