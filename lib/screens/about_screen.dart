import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class About_Screen extends StatefulWidget {
  @override
  State<About_Screen> createState() => _About_Screen();
}

class _About_Screen extends State<About_Screen> {
  //const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,

        // backgroundColor: Colors.amber[300],
        title: Text(
          'About US',
        ),
      ),

      // color: Colors.white,
      body: Column(children: <Widget>[
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 3.h),
                  Center(
                      child: Image.asset("assets/images/scarlet.png",
                          width: 60.w)),
                  SizedBox(height: 3.h),
                  Center(
                      child: Image.asset(
                    "assets/images/aboutus.png",
                    width: 60.w,

                    // height: 320,
                  )),
                  Text(
                    "About Task Management App",
                    style: GoogleFonts.montserrat(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          // Text(
                          //   "SCARLET-Order Management application is designed to facilitate its users regarding order management operations, Collection, receipts from customer.There is restricted use of this application and only for the authorized personnes 1 of Saif Brothers.",
                          //   textAlign: TextAlign.center,
                          //   style: GoogleFonts.montserrat(
                          //     fontSize: 14.sp,
                          //     // color: Theme.of(context).colorScheme.primary,
                          //   ),
                          // ),
                          SizedBox(height: 3.h),
                          Text(
                            "Task Management App",
                            style: GoogleFonts.montserrat(fontSize: 14.sp),
                          ),
                          SizedBox(height: 0.5.h),

                          Text(
                            "Version : 1.0.0",
                            style: GoogleFonts.montserrat(fontSize: 13.sp),
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
        Text(
          "Developed by SCARLET IT Systems",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1.h),
      ]),

      // drawer: MyDrawer(),
    );
  }
}
