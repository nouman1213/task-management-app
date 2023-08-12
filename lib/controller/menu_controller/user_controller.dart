import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../model/userlist_model.dart';

class UserController extends GetxController {
  String selectedAssignTo = 'Select AssignTo';
  int selectedAssignId = -1;
  RxList<UserListModel> userList = <UserListModel>[].obs;
  RxBool isInsertingUser = false.obs;
  TextEditingController insertUserController = TextEditingController();
  TextEditingController updateUserController = TextEditingController();
  TextEditingController userPassController = TextEditingController();

  final box = GetStorage();
  var fkcoid;
  @override
  void onInit() {
    super.onInit();
    fkcoid = box.read("fkCoid");
    fetchUserList();
  }

  Future<void> fetchUserList() async {
    try {
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/Account/GetUserList?coid=$fkcoid"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        userList.value =
            jsonData.map((e) => UserListModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load data from api");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<void> insertUser(loginId, usPW, fkcoid) async {
    try {
      isInsertingUser.value = true;
      final response = await http.post(
        Uri.parse("https://erm.scarletsystems.com:132/Api/Account/NewUser"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "LOGINID": loginId,
          "USPW": usPW,
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
      isInsertingUser.value = false;
    }
  }

  Future<void> deleteUser(int? usid) async {
    try {
      isInsertingUser.value = true;
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/Account/DeleteUser?usid=$usid"));

      if (response.statusCode == 200) {
        // final List<dynamic> jsonData = json.decode(response.body);
      } else {
        throw Exception("Failed to delete data");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<void> updateUser(
    loginId,
    usid,
    usPW,
  ) async {
    try {
      isInsertingUser.value = true;
      final response = await http.post(
        Uri.parse("https://erm.scarletsystems.com:132/Api/Account/UpdateUser"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "LOGINID": loginId,
          "USID": usid,
          "USPW": usPW,
        }),
      );

      if (response.statusCode == 200) {
        print("user inserted successfully");
      } else {
        throw Exception("Failed to insert user");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      // Set loading state back to false
      isInsertingUser.value = false;
    }
  }
}
