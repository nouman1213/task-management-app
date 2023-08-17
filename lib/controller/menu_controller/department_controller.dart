import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

import '../../model/derpartment_model.dart';

class DepartmentContoller extends GetxController {
  String selectedDepartment = 'Select Department';
  int selectedDepartmentId = -1;
  RxList<GetDepartmentListModel> departmentList =
      <GetDepartmentListModel>[].obs;
  RxBool isInsertingDepartment = false.obs;
  TextEditingController insertDepartmentController = TextEditingController();
  TextEditingController updateDepartmentController = TextEditingController();
  final box = GetStorage();
  var fkcoid;
  @override
  void onInit() {
    super.onInit();
    fkcoid = box.read("fkCoid");
    // print("fckiddd:::$fkcoid");
    fetchDepartmentList();
  }

  Future<void> fetchDepartmentList() async {
    try {
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/Department/GetDepartment?coid=$fkcoid"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        departmentList.value =
            jsonData.map((e) => GetDepartmentListModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load data from api");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  // insert priority method
  Future<void> insertDepartment(context, departmentName, fkcoid) async {
    try {
      isInsertingDepartment.value = true;
      final response = await http.post(
        Uri.parse(
            "https://erm.scarletsystems.com:132/Api/Department/InsertDepartment"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "DPNAME": departmentName,
          "FKCOID": fkcoid,
        }),
      );

      if (response.statusCode == 200) {
        GFToast.showToast('department add successfully!', context,
            toastDuration: 4, backgroundColor: Colors.green.shade600);
        print("department inserted successfully");
      } else if (response.statusCode == 400) {
        print('statuscode:${response.statusCode == 400}');
        GFToast.showToast(
            'Unable to Delete Record Due to  Foreign key Constraint', context,
            toastDuration: 4, backgroundColor: Colors.red.shade600);
        isInsertingDepartment.value = false;
        // Handle foreign key constraint error
      } else {
        isInsertingDepartment.value = false;

        throw Exception("Failed to insert department");
      }
    } catch (e) {
      isInsertingDepartment.value = false;

      print("Error: $e");
    }
  }

  Future<void> deleteDepartment(context, int? drtId) async {
    try {
      isInsertingDepartment.value = true;
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/Department/DeleteDepartment?DPID=$drtId"));

      if (response.statusCode == 200) {
        GFToast.showToast('department delete successfully!', context,
            toastDuration: 4, backgroundColor: Colors.green.shade600);
        // final List<dynamic> jsonData = json.decode(response.body);
      } else if (response.statusCode == 400) {
        print('statuscode:${response.statusCode == 400}');
        GFToast.showToast(
            'Unable to Delete Record Due to  Foreign key Constraint', context,
            toastDuration: 4, backgroundColor: Colors.red.shade600);
        isInsertingDepartment.value = false;
        // Handle foreign key constraint error
      } else {
        throw Exception("Failed to delete data");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<void> updateDepartment(context, departmentName, fkcoid, drtId) async {
    try {
      isInsertingDepartment.value = true;
      final response = await http.post(
        Uri.parse(
            "https://erm.scarletsystems.com:132/Api/Department/UpdateDepartment"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "DPNAME": departmentName,
          "FKCOID": fkcoid,
          "DPID": drtId,
        }),
      );

      if (response.statusCode == 200) {
        GFToast.showToast('department update successfully!', context,
            toastDuration: 4, backgroundColor: Colors.green.shade600);
        print("department inserted successfully");
      } else if (response.statusCode == 400) {
        print('statuscode:${response.statusCode == 400}');
        GFToast.showToast('Unable to Insert Duplicate Record!', context,
            toastDuration: 4, backgroundColor: Colors.red.shade600);
        isInsertingDepartment.value = false;
        // Handle foreign key constraint error
      } else {
        isInsertingDepartment.value = false;
        throw Exception("Failed to insert department");
      }
    } catch (e) {
      isInsertingDepartment.value = false;
      print("Error: $e");
    }
  }
}
