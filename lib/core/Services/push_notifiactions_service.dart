import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  init() {
    print("Initialised");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}
