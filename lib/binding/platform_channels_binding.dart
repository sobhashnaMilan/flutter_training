import 'package:flutter_training/controller/PlatformChannelsController.dart';
import 'package:flutter_training/controller/home_controller.dart';
import 'package:get/instance_manager.dart';

class PlatformChannelsBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put<PlatformChannelsController>(PlatformChannelsController());
    Get.lazyPut(() => PlatformChannelsController(),fenix: true);
    Get.lazyPut(() => HomeController(),fenix: true);
  }
}
