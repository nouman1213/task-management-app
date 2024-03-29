import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

import '../../model/priority_list_model.dart';

class PriorityContoller extends GetxController {
  String selectedPriority = 'Select Priority';
  int selectedPriorityId = -1;
  RxList<GetPriorityList> priorityList = <GetPriorityList>[].obs;
  RxBool isInsertingPriority = false.obs;
  TextEditingController insertPriorityController = TextEditingController();
  TextEditingController updatePriorityController = TextEditingController();
  final box = GetStorage();
  var fkcoid;
  @override
  void onInit() {
    super.onInit();
    fkcoid = box.read("fkCoid");
    // print("fckiddd:::$fkcoid");
    fetchPriorityList();
  }

  Future<void> fetchPriorityList() async {
    try {
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/TaskPriority/GetPriority?coid=$fkcoid"));

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
  Future<void> insertPriority(context, priorityName, fkcoid) async {
    try {
      isInsertingPriority.value = true;
      final response = await http.post(
        Uri.parse(
            "https://erm.scarletsystems.com:132/Api/TaskPriority/InsertPriority"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "PRTNAME": priorityName,
          "FKCOID": fkcoid,
        }),
      );

      if (response.statusCode == 200) {
        GFToast.showToast('priority add successfully!', context,
            toastDuration: 4, backgroundColor: Colors.green.shade600);
        print("Priority inserted successfully");
      } else if (response.statusCode == 400) {
        print('statuscode:${response.statusCode == 400}');
        GFToast.showToast(
            'Unable to Delete Record Due to  Foreign key Constraint', context,
            toastDuration: 4, backgroundColor: Colors.red.shade600);
        isInsertingPriority.value = false;
        // Handle foreign key constraint error
      } else {
        isInsertingPriority.value = false;

        throw Exception("Failed to insert priority");
      }
    } catch (e) {
      isInsertingPriority.value = false;

      print("Error: $e");
    }
  }

  Future<void> deletePriority(context, int? prtId) async {
    try {
      isInsertingPriority.value = true;
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/TaskPriority/DeletePriority?PRTID=$prtId"));

      if (response.statusCode == 200) {
        GFToast.showToast('priority delete successfully!', context,
            toastDuration: 4, backgroundColor: Colors.green.shade600);
        // final List<dynamic> jsonData = json.decode(response.body);
      } else if (response.statusCode == 400) {
        print('statuscode:${response.statusCode == 400}');
        GFToast.showToast(
            'Unable to Delete Record Due to  Foreign key Constraint', context,
            toastDuration: 4, backgroundColor: Colors.red.shade600);
        isInsertingPriority.value = false;
        // Handle foreign key constraint error
      } else {
        throw Exception("Failed to delete data");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<void> updatePriority(context, priorityName, fkcoid, prtId) async {
    try {
      isInsertingPriority.value = true;
      final response = await http.post(
        Uri.parse(
            "https://erm.scarletsystems.com:132/Api/TaskPriority/UpdatePriority"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "PRTNAME": priorityName,
          "FKCOID": fkcoid,
          "PRTID": prtId,
        }),
      );

      if (response.statusCode == 200) {
        GFToast.showToast('priority update successfully!', context,
            toastDuration: 4, backgroundColor: Colors.green.shade600);
        print("Priority inserted successfully");
      } else if (response.statusCode == 400) {
        print('statuscode:${response.statusCode == 400}');
        GFToast.showToast('Unable to Insert Duplicate Record!', context,
            toastDuration: 4, backgroundColor: Colors.red.shade600);
        isInsertingPriority.value = false;
        // Handle foreign key constraint error
      } else {
        isInsertingPriority.value = false;
        throw Exception("Failed to update priority");
      }
    } catch (e) {
      isInsertingPriority.value = false;
      print("Error: $e");
    }
  }
}
