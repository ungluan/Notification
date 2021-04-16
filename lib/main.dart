import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initializationAndroidSettings = AndroidInitializationSettings('flight');
    var initializationSettings = InitializationSettings(android: initializationAndroidSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification() async{
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channelID',
      'channelName',
      'channelDescription',
      icon: 'flight',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var notificationDetail = NotificationDetails(android: androidPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(0, 'title', 'body', notificationDetail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Show Notification'),
          onPressed: () async {
            await showNotification();
          },
        ),
      ),
    );
  }
}
