// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// class LocalNotificationService {
//   LocalNotificationService();

//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject();

//   Future<void> inialize() async {
//     tz.initializeTimeZones();
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('appicon');

//     IOSInitializationSettings iosInitializationSettings =
//         IOSInitializationSettings(
//             defaultPresentAlert: true,
//             defaultPresentBadge: true,
//             defaultPresentSound: true,
//             onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

//     final InitializationSettings settings = InitializationSettings(
//         android: androidInitializationSettings, iOS: iosInitializationSettings);

//     await flutterLocalNotificationsPlugin.initialize(settings,
//         onSelectNotification: onSelectNotification);
//   }

//   Future<NotificationDetails> _notificationDetails() async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'channel_id',
//       'channel_name',
//       channelDescription: 'description',
//       importance: Importance.max,
//       priority: Priority.max,
//       playSound: true,
//     );

//     const IOSNotificationDetails iosNotificationDetails =
//         IOSNotificationDetails();
//     return const NotificationDetails(
//         android: androidNotificationDetails, iOS: iosNotificationDetails);
//   }

//   Future<void> showNotification(
//       {required int id, required String title, required String body}) async {
//     final details = await _notificationDetails();
    
//     await flutterLocalNotificationsPlugin.show(id, title, body, details);
//   }

//   Future<void> showScheduledNotification(
//       {required int id,
//       required String title,
//       required String body,
//       required int seconds}) async {
//     final details = await _notificationDetails();
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         id,
//         title,
//         body,
//         tz.TZDateTime.from(
//             DateTime.now().add(Duration(seconds: seconds)), tz.local),
//         details,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
//   }

//   Future<void> showNotificationWithPayload(
//       {required int id,
//       required String title,
//       required String body,
//       required String payload}) async {
//     final details = await _notificationDetails();
//     await flutterLocalNotificationsPlugin.show(id, title, body, details,
//         payload: payload);
//   }

//   void _onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {
//     print('id $id');
//   }

//   void onSelectNotification(String? payload) {
//     print('$payload');

//     if (payload != null && payload.isNotEmpty) {
//       selectNotificationSubject.add(payload);
//     }
//   }

//    tz.TZDateTime _nextInstanceOfTenAM(int hour, int minutes) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }
// }
