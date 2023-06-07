import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/components/roundbutton.dart';
import 'package:task_management_app/components/textfield.dart';
import 'package:task_management_app/controller/auth/signup_controller.dart';
import 'package:task_management_app/screens/auth_screen/login_screen.dart';

class RegisterationScreen extends StatelessWidget {
  // const RegisterationScreen({Key? key}) : super(key: key);
  final _controller = Get.put(SignUpController());
  final GlobalKey<FormState> frmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                Lottie.asset('assets/images/user.json', height: 32.h),
                Text(
                  'Register Your Account',
                  style: GoogleFonts.indieFlower(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        // height: 1.5,
                        fontSize: 26.sp),
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  height: 47.h,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Form(
                    key: frmKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(1.h),
                          child: MyTextForm(
                            hintText: "Company name",
                            controller: null,
                            validator: (text) {
                              if (text.toString().isEmpty ||
                                  text.toString().length < 3) {
                                return "Please enter valid company name";
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.h),
                          child: MyTextForm(
                            hintText: "Email",
                            controller: null,
                            sufixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            validator: (text) {
                              if (text.toString().isEmpty ||
                                  text.toString().length < 3) {
                                return "Please enter valid email";
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.h),
                          child: Obx(
                            () => MyTextForm(
                              hintText: "Password",
                              controller: null,
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
                        SizedBox(height: 1.h),
                        Obx(() => RoundButton(
                              title: "SignUp",
                              onTap: () {
                                if (frmKey.currentState!.validate()) {
                                  _controller.signup();
                                }
                              },
                              backgroundColor: Colors.blue.shade900,
                              loading: _controller.loading.value,
                            )),
                        SizedBox(height: 1.h),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => LoginScreen(),
                                transition: Transition.leftToRightWithFade);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
