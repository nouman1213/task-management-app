import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/screens/home_screen.dart';

class loginController extends GetxController {
  RxBool obscureText = true.obs;

  void toggleObscureText() {
    obscureText.toggle();
  }

  final RxBool loading = false.obs;

  void login() async {
    loading.value = true;
    await Future.delayed(Duration(seconds: 3));
    Get.offAll(() => HomeScreen());
    loading.value = false;
  }
}