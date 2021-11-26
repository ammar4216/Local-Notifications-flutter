import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FlutterNotifications extends StatefulWidget {
  const FlutterNotifications({Key? key}) : super(key: key);

  @override
  _FlutterNotificationsState createState() => _FlutterNotificationsState();
}

class _FlutterNotificationsState extends State<FlutterNotifications> {
  FlutterLocalNotificationsPlugin fltrNotification =
      new FlutterLocalNotificationsPlugin();

  void initState() {
    super.initState();
    var androidInitilize =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
        new InitializationSettings(androidInitilize, iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails("Channel ID",
        "Ammar Ahmed", "This is Lab 4 Local Notifications in Flutter ",
        importance: Importance.Max);
    var iOsDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(androidDetails, iOsDetails);

    await fltrNotification.show(
        0, "Lab 4", "Local Notification Lab", generalNotificationDetails,
        payload: "Lab Task");
  }

  Future _showScheduledNotification() async {
    var androidDetails = new AndroidNotificationDetails("Channel ID",
        "Ammar Ahmed", "This is Lab 4 Local Notifications in Flutter ",
        importance: Importance.Max);
    var iOsDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(androidDetails, iOsDetails);

    var scheduledTime = new DateTime.now().add(Duration(seconds: 10));
    fltrNotification.schedule(
        1,
        "Flutter Sceduled Notification after 10 Seconds",
        'Lab Task',
        scheduledTime,
        generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Local Notifications - Lab 4'),
          backgroundColor: Colors.red,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: deprecated_member_use
            Center(
              child: RaisedButton(
                onPressed: _showNotification,
                child: Text('Flutter Instant Notification'),
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: _showScheduledNotification,
                child: Text('Flutter scheduled Notification'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }
}
