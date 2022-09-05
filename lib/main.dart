import '../../util/app_common_stuffs/app_routes.dart';
import '../../controllers/app/app_controller.dart';
import '../../language/language_util.dart';
import '../../util/app_common_stuffs/screen_routes.dart';
import '../../util/import_export_util.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  Get.put<AppController>(AppController());
  runApp(
    MyApp(currentLocale: await LanguageUtil.loadCurrentLanguage()),
  );
}

class MyApp extends StatelessWidget {
  Locale currentLocale;

  MyApp({Key? key, required this.currentLocale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (controller) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: AppRoutes.routes,
          // initialRoute: ScreenRoutesConstant.loginScreen,
          textDirection: TextDirection.ltr,
          initialRoute: ScreenRoutesConstant.splashScreen,
          translations: LanguageUtil(),
          locale: currentLocale,
          fallbackLocale: LanguageUtil.fallbackLocale,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        );
      },
    );
  }
}
