import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  // Initialised firebase messaging and local notofications
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void init(BuildContext context) {
    // Initialising android and Ios methods for local notification
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        print(payload);
      },
    );

    print('Context : ${context.owner}');

    // Configuring Firebase callbacks
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        showNotification(
          message['notification']['title'],
          message['notification']['body'],
        );
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        Navigator.pushNamed(context, '/allstore');
        print("onLaunch: $message");
        // Navigator.pushNamed(context, '/notify');
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  void showNotification(String title, String body) async {
    print("Showing Notification...");
    await _orderStatusNotification(title, body);
  }

  Future<void> _orderStatusNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'ORDER_STATUS',
      'Order status channel',
      'Channel to revcive notifications for order status',
      channelShowBadge: true,
      priority: Priority.Max
    );

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSChannelSpecifics,
    );
    print("All Initialised");
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
