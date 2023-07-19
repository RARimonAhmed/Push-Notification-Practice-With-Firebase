import 'package:flutter/material.dart';
import 'package:flutter_push_notification_practice/controller/notification_services.dart';
class HomeScreeen extends StatefulWidget {
  const HomeScreeen({Key? key}) : super(key: key);

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {

  NotificationServiceClass notificationServices = NotificationServiceClass();


  @override
  void initState() {
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    // notificationServices.isTockenRefresh();
    notificationServices.getDeviceTocken().then((value) => {
      print("Device tocken is $value"),
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Flutter Push Notification"),),);
  }
}
