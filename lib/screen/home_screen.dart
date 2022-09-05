import 'package:flutter/material.dart';
import 'package:flutter_training/screen/api_demo/api_demo.dart';
import 'package:flutter_training/utils/app_string.dart';
import 'package:flutter_training/utils/common/app_bar.dart';
import 'package:get/get.dart';
import '../controller/PlatformChannelsController.dart';
import '../controller/home_controller.dart';
import '../utils/common/custom_button.dart';
import '../utils/routes/screen_routes.dart';
import 'equatable/equatable_demo.dart';
import 'firebase_authentication/auth_firebase.dart';
import 'firebase_deep_linking/deep_link_firebase.dart';
import 'location/location.dart';
import 'multi_language_support/multi_language.dart';
import 'navigator/navigator_one.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlatformChannelsController controller =
      Get.find<PlatformChannelsController>();

  @override
  void initState() {
    super.initState();
    controller.name.value = "change value";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (controller) {
          /// app bar with textField
          /*CustomAppBar(chkText: (value){
            flutterPrint(msg: value);
          })*/

          return Scaffold(
              appBar: CustomAppBar(toolbarText: "Home Screen"),
              body: homeView());
        });
  }

  Widget homeView() {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.brown,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomButton(
                onPress: () {
                  Get.to(const FireBaseAuth());
                },
                text: AppString().btnFirebaseOtp),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                onPress: () {
                  Get.to(const ApiDemo());
                },
                text: AppString().btnApiDemo),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                onPress: () => Get.to(const DeepLinkFirebase()),
                text: AppString().btnDeepLink),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                onPress: () => Get.to(const MultiLanguage()),
                text: AppString().btnMultiLanguage),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                onPress: () => Get.to(const LocationService()),
                text: AppString().btnLocationService),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                onPress: () =>
                    Get.toNamed(ScreenRoutesConstant.platformChannelsScreen),
                text: AppString().btnPlatformChannels),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                onPress: () =>
                    Get.toNamed(ScreenRoutesConstant.notificationScreen),
                text: AppString().btnNotification),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                onPress: () => Get.to(const NavigatorOne()),
                text: AppString().btnNavigator),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                onPress: () => Get.to(const EquatableDemo()),
                text: AppString().btnEquatableDemo),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget homeAppBar() {
    return AppBar(
      title: Text(AppString().appName),
    );
  }
}
