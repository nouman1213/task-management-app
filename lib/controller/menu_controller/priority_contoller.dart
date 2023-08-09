import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/priority_list_model.dart';

class PriorityContoller extends GetxController {
  RxList<GetPriorityList> priorityList = <GetPriorityList>[].obs;
  RxBool isInsertingPriority = false.obs;
  TextEditingController insertPriorityController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    fetchPriorityList();
  }

  Future<void> fetchPriorityList() async {
    try {
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/api/TaskPriority/GetPriority"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        priorityList.value =
            jsonData.map((e) => GetPriorityList.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load data from api");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  // insert priority method
  Future<void> insertPriority(String priorityName) async {
    try {
      isInsertingPriority.value = true;
      final response = await http.post(
        Uri.parse(
            "https://erm.scarletsystems.com:132/Api/TaskPriority/InsertPriority"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"PRTNAME": priorityName}),
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
      isInsertingPriority.value = false;
    }
  }
}
