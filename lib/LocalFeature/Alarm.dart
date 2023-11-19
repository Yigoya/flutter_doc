import 'dart:async';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOn = false;
  int alarmId = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm Manager Example'),
      ),
      body: Row(
        children: [
          Text('Scheduled notifications will appear every minute.'),
          Switch(
            value: isOn,
            onChanged: (value) {
              setState(() {
                isOn = value;
              });
              if (isOn == true) {
                AndroidAlarmManager.oneShot(
                    Duration(seconds: 5), alarmId, fireAlarm);
              }
            },
          )
        ],
      ),
    );
  }
}
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> callback() async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     '2',
//     'your_channel_name',
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'Periodic Notification',
//     'This is a periodic notification.',
//     platformChannelSpecifics,
//     payload: 'item x',
//   );
// }

// Future<void> mainCallback() async {
//   await AndroidAlarmManager.oneShot(
//     const Duration(seconds: 5),
//     0,
//     callback,
//   );
// }

void fireAlarm() {
  print('Alarm fired at ${DateTime.now()}');
}
