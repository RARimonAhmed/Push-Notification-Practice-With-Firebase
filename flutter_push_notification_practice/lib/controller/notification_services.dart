// import 'dart:math';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServiceClass {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User provisional permission");
    } else {
      print("User denied permission");
    }
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitilization =
        const AndroidInitializationSettings("");
    var iosInitilization = DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
        android: androidInitilization, iOS: iosInitilization);
    await flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {});
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    if (message.notification != null) {
      AndroidNotificationChannel channel = AndroidNotificationChannel(
          Random.secure().nextInt(10000).toString(),
          "High Importance Notification",
          importance: Importance.max);
      AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
          channel.id.toString(), channel.name.toString(),
          channelDescription: "My channel description",
          importance: Importance.high,
          priority: Priority.high,
          ticker: "Ticker");
      const DarwinNotificationDetails darwinNotificationDetails =
      DarwinNotificationDetails(
          presentAlert: true, presentBadge: true, presentSound: true);
      NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: darwinNotificationDetails);
      Future.delayed(Duration.zero, () {
        flutterLocalNotificationsPlugin.show(
            0,
            message.notification!.title.toString(),
            message.notification!.body.toString(),
            notificationDetails);
      });
    }else{
      print("There is no data");
    }

  }

  Future<String> getDeviceTocken() async {
    String? tocken = await messaging.getToken();
    return tocken.toString();
  }

  void isTockenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
    print("refresh tocken");
  }
}
