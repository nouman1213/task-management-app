import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    DarwinInitializationSettings initializationIos =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationIos);
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> scheduleNotification(
    int userId,
    String title,
    String body,
  ) async {
    print("Scheduling notification for user $userId: $title - $body");
    // const int notificationId = 0; // Assign a unique notification ID

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your_channel_id', // Replace with your channel ID
            'your_channel_name', // Replace with your channel name
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true,
            icon: 'flutter_logo',
            channelShowBadge: true,
            largeIcon: DrawableResourceAndroidBitmap('flutter_logo'));

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Schedule the notification
    await notificationsPlugin.show(
      userId,
      title,
      body,
      platformChannelSpecifics,
      payload: 'task_payload', // Customize payload if needed
    );
  }

  Future<void> simpleNotificationShow() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('Channel_id', 'Channel_title',
            priority: Priority.high,
            importance: Importance.max,
            icon: 'flutter_logo',
            channelShowBadge: true,
            largeIcon: DrawableResourceAndroidBitmap('flutter_logo'));

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notificationsPlugin.show(
        0, 'Alert', 'New task assign for you!', notificationDetails);
  }

  Future<void> bigPictureNotificationShow() async {
    BigPictureStyleInformation bigPictureStyleInformation =
        const BigPictureStyleInformation(
            DrawableResourceAndroidBitmap('flutter_logo'),
            contentTitle: 'Code Compilee',
            largeIcon: DrawableResourceAndroidBitmap('flutter_logo'));

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('big_picture_id', 'big_picture_title',
            priority: Priority.high,
            importance: Importance.max,
            styleInformation: bigPictureStyleInformation);

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notificationsPlugin.show(
        1, 'Big Picture Notification', 'New Message', notificationDetails);
  }
}
