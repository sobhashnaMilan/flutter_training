import '../../bindings/common/home_binding.dart';
import '../../ui/common/home_screen.dart';
import '../../ui/common/splash_screen.dart';
import '../../util/app_common_stuffs/screen_routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: ScreenRoutesConstant.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: ScreenRoutesConstant.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
