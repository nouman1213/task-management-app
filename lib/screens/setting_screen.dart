import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/notification_services.dart/notif_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var isReminderEnabled = false;
  final _box = GetStorage();

  final _key = 'isDarkMode';

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Settings',
        ),
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      ),
      body: Padding(
        padding: EdgeInsets.all(1.h),
        child: Column(
          children: [
            SwitchListTile(
                title: Text(
                  'Change Theme',
                  // color: blackColor,
                ),
                value: theme == ThemeMode.dark,
                onChanged: (v) => switchTheme()),
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
            // ElevatedButton(
            //     onPressed: () {
            //       NotificationService().simpleNotificationShow();
            //     },
            //     child: Text("Show notifiaction")),
          ],
        ),
      ),
    );
  }
}
