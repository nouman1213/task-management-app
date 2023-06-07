import 'package:get/get.dart';

import '../../screens/main_screen.dart';

class SignUpController extends GetxController {
  RxBool obscureText = true.obs;

  void toggleObscureText() {
    obscureText.toggle();
  }

  final RxBool loading = false.obs;

  void signup() async {
    loading.value = true;
    await Future.delayed(Duration(seconds: 3));
    Get.offAll(() => MainScreen());
    loading.value = false;
  }
}
