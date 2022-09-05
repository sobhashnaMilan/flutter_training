import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_training/utils/common/app_bar.dart';
import 'package:flutter_training/utils/fcm/notification_service.dart';
import 'package:get/get.dart';

import '../../utils/common/custom_button.dart';
import '../../utils/styles_utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var arguments = Get.arguments;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'channelId', // id
    'channelId', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications()
        .actionStream
        .listen((ReceivedNotification receivedNotification) {
      flutterPrint(msg: "💣 😀 =====> AwesomeNotifications -> click");
      var mReceivedNotification = receivedNotification.toMap().toString();
      flutterPrint(
          msg: "💣 😀 =====> AwesomeNotifications -> $mReceivedNotification");
    });
    if (arguments != null) {
      flutterPrint(msg: "💣 😀 =====> arguments -> ${arguments[0].toString()}");
    }
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
  }

  void onSelectNotification(String payload) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Hello Everyone"),
              content: Text(payload),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(toolbarText: "notification"),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomButton(
              text: "local notification",
              onPress: () {
                notificationDefaultSound();
              },
            ),
            CustomButton(
              text: "Awesome notification",
              onPress: () {
                showAwesomeNotification();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future notificationDefaultSound() async {
    flutterLocalNotificationsPlugin.show(
        NotificationService().generateRandom(),
        'New Alert',
        'How to show Local Notification',
        const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_channel',
              importance: Importance.max,
              priority: Priority.high,
            ),
            iOS: IOSNotificationDetails()),
        payload: 'Default Sound');

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings('app_icon'),
          iOS: IOSInitializationSettings()),
      onSelectNotification: (payload) {
        if (nullCheck(payload)) return;
        onSelectNotification(payload!);
      },
    );
  }

  showAwesomeNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: NotificationService().generateRandom(),
        channelKey: 'basic_channel',
        title: 'Simple Notification',
        body: 'Simple body',
        notificationLayout: NotificationLayout.BigPicture,
        displayOnBackground: true,
        displayOnForeground: true,
        color: Colors.red,
        backgroundColor: Colors.brown,
        largeIcon:
            'https://protocoderspoint.com/wp-content/uploads/2021/05/Monitize-flutter-app-with-google-admob-min-741x486.png',
        bigPicture:
            'https://protocoderspoint.com/wp-content/uploads/2021/05/Monitize-flutter-app-with-google-admob-min-741x486.png',
      ),
      actionButtons: [
        NotificationActionButton(
            key: 'reply',
            label: 'Reply',
            enabled: true,
            buttonType: ActionButtonType.InputField,
            autoDismissible: true,
            showInCompactView: true,
            icon: "resource://drawable/app_icon")
      ],
    );
  }
}
