import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var isReminderEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Settings',
        ),
        // backgroundColor: Colors.amber[300],
      ),
      body: Padding(
        padding: EdgeInsets.all(1.h),
        child: Column(
          children: [
            ListTile(
                title: Text('Reminder'),
                trailing: Switch(
                  value: isReminderEnabled,
                  onChanged: (value) {
                    setState(() {
                      isReminderEnabled = value;
                    });
                  },
                )),
            // SizedBox(height: 1.h),
            ListTile(
                title: Text('Reminder me  before'), trailing: Text('15 mins')),
          ],
        ),
      ),
    );
  }
}
