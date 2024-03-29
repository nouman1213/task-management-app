import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/components/roundbutton.dart';
import 'package:task_management_app/controller/auth/login_controller.dart';
import '../../components/keybord_hider.dart';
import '../../components/textfield.dart';

class LoginScreen extends StatelessWidget {
  final _controller = Get.put(loginController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardHider(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue[200]!,
                Colors.blue[800]!,
                Colors.blue[900]!,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/images/user.json', height: 34.h),
                  Text(
                    'Log In Now',
                    style: GoogleFonts.indieFlower(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 26.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    height: 42.h,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1.h),
                            child: MyTextForm(
                              hintText: "Email",
                              controller: _controller.emailController,
                              sufixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              validator: (text) {
                                if (text.toString().isEmpty ||
                                    text.toString().length < 3) {
                                  return "Please enter valid name";
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(1.h),
                            child: Obx(
                              () => MyTextForm(
                                hintText: "Password",
                                controller: _controller.passController,
                                obscurText: _controller.obscureText.value,
                                sufixIcon: IconButton(
                                  onPressed: () {
                                    _controller.toggleObscureText();
                                  },
                                  icon: Icon(
                                    _controller.obscureText.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white,
                                  ),
                                ),
                                validator: (text) {
                                  if (text.toString().isEmpty ||
                                      text.toString().length < 3) {
                                    return "Please enter valid password";
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Obx(() => RoundButton(
                                title: "Login",
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    _controller.loginUser();
                                  }
                                },
                                backgroundColor: Colors.blue.shade900,
                                loading: _controller.loading.value,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
