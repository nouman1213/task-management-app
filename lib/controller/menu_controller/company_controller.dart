import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/company_list_model.dart';

class CompanyController extends GetxController {
  RxList<CompanyListModel> companyList = <CompanyListModel>[].obs;
  RxBool isInsertingCompany = false.obs;
  TextEditingController insertCompanyController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    fetchCompanyList();
  }

  Future<void> fetchCompanyList() async {
    try {
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/Company/GetCompanyList"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        companyList.value =
            jsonData.map((e) => CompanyListModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load data from api");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  // insert priority method
  Future<void> insertCompany(String companyName) async {
    try {
      isInsertingCompany.value = true;
      final response = await http.post(
        Uri.parse(
            "https://erm.scarletsystems.com:132/Api/Company/InsertCompany"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"CONAME": companyName}),
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
      isInsertingCompany.value = false;
    }
  }

  Future<void> deleteCompany(int? cOID) async {
    // Implement your delete logic here, for example, make an API call to delete the company
    // After successful deletion, update the company list
  }
}
