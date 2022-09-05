import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_training/utils/app_string.dart';
import 'package:flutter_training/utils/fcm/notification_service.dart';
import 'package:flutter_training/utils/localization/local_string.dart';
import 'package:flutter_training/utils/routes/app_routes.dart';
import 'package:flutter_training/utils/routes/screen_routes.dart';
import 'package:flutter_training/utils/styles_utils.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().getFCMToken();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  AwesomeNotifications().initialize(
      'resource://drawable/app_icon',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  runApp(MyApp());
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().setupFlutterNotifications();
  flutterPrint(msg: "💣 😀 =====> onBackgroundMessage: $message");
  NotificationService().displayNotificationView(message);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  var string = AppString();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: string.appName,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      translations: LocaleString(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ScreenRoutesConstant.homeScreen,
      getPages: AppRoutes.routes,
    );
    /*return GetMaterialApp(
      title: string.appName,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      translations: LocaleString(),
      initialRoute: ScreenRoutesConstant.homeScreen,
      getPages: AppRoutes.routes,
      theme: ThemeData(
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Color(0xFFFFFFFF),
          ),
          fontFamily: GoogleFonts.lato().fontFamily),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      builder: (context, widget) => ResponsiveWrapper.builder(widget,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
    );*/
  }
}
