import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../model/status_list_model.dart';

class TaskStatusController extends GetxController {
  RxList<GetStatusList> taskStatusList = <GetStatusList>[].obs;
  RxBool isInsertingStatus = false.obs;
  TextEditingController insertStatusController = TextEditingController();
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
  Future<void> insertStatus(String statusName) async {
    try {
      isInsertingStatus.value = true;
      final response = await http.post(
        Uri.parse(
            "https://erm.scarletsystems.com:132/Api/TaskStatus/InsertTStatus"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"STSNAME": statusName}),
      );

      if (response.statusCode == 200) {
        print("Status inserted successfully");
      } else {
        throw Exception("Failed to insert Status");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      // Set loading state back to false
      isInsertingStatus.value = false;
    }
  }
}
