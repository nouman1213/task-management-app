import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/screens/main_screen.dart';

import 'screens/auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _box = GetStorage();
  var email;
  var pass;
  void checkUserCredential() async {
    await Future.delayed(Duration(seconds: 3)); // Delay execution
    try {
      email = _box.read('loginId');
      pass = _box.read('uspass');
      print('Stored Email: $email');
      print('Stored Password: $pass');

      if (email != null && pass != null) {
        Get.offAll(() => MainScreen());
      } else {
        Get.offAll(() => LoginScreen());
      }
    } catch (e) {
      print('Navigation Error: $e');
    }
  }

  void initState() {
    super.initState();

    checkUserCredential();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Colors.blue[200]!,
        //       Colors.blue[800]!,
        //       Colors.blue[900]!,
        //     ],
        //   ),
        // ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // FadeInDownBig(
                //     child: Lottie.asset('assets/images/task.json', height: 40.h)),
                FadeInDownBig(
                    child: Image.asset(
                  'assets/images/scarlet.png',
                  height: 80,
                )),
                SizedBox(height: 20),
                FadeInUpBig(
                  child: Text(
                    'Task Management App',
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(
                        color: Colors.red[900],
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                      ),
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
