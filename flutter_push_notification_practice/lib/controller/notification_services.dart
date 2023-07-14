import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServiceClass{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("User Granted permission");
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print("User provisional permission");
    }else{
      print("User denied permission");
    }
  }
}