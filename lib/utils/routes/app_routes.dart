import 'package:flutter_training/screen/notification/notification_screen.dart';
import 'package:get/get.dart';

import 'package:flutter_training/screen/home_screen.dart';
import 'package:flutter_training/screen/platform_channels/platform_channels.dart';
import 'package:flutter_training/utils/routes/screen_routes.dart';

import '../../binding/platform_channels_binding.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: ScreenRoutesConstant.homeScreen,
      page: () => const HomeScreen(),
      binding: PlatformChannelsBinding(),
    ),
    GetPage(
      name: ScreenRoutesConstant.platformChannelsScreen,
      page: () => const PlatformChannelsScreen(),
      binding: PlatformChannelsBinding(),
    ),
    GetPage(
      name: ScreenRoutesConstant.notificationScreen,
      page: () => const NotificationScreen(),
      binding: PlatformChannelsBinding(),
    ),
  ];
}
