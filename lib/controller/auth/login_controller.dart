import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../../constant/const.dart';
import '../../screens/main_screen.dart';

class loginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  RxBool obscureText = true.obs;
  final _box = GetStorage();

  void toggleObscureText() {
    obscureText.toggle();
  }

  final RxBool loading = false.obs;

  void clearControllers() {
    emailController.text = '';
    passController.text = '';
  }

  Future<void> loginUser() async {
    final url = Uri.https(
      'erm.scarletsystems.com:132',
      '/Api/Account/GetUser',
      {
        'usid': emailController.text,
        'pwd': passController.text,
      },
    );

    try {
      loading.value = true;
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _box.write('usid', jsonData['USID']);
        _box.write('loginId', jsonData['LOGINID']);
        _box.write('uspass', jsonData['USPW']);
        _box.write('fkRoll', jsonData['FKROLE']);
        _box.write('fkCoid', jsonData['FKCOID']);
        // print('USID: ${jsonData['USID']}');
        // print('LOGINID: ${jsonData['LOGINID']}');
        // print('USPW: ${jsonData['USPW']}');
        // print('FKCOID: ${jsonData['FKCOID']}');
        // print('FKROLE: ${jsonData['FKROLE']}');

        print('Response: ${response.body}');
        loading.value = false;
        clearControllers();
        Get.offAll(() => MainScreen());
      } else {
        // Handle error response
        loading.value = false;
        showAlert(
            title: 'Alert', message: "Please enter valide user and password!");
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      loading.value = false;

      print('Error: $e');
    }
  }
}
