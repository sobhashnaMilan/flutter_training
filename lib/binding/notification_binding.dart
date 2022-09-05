import 'package:flutter_training/controller/notification_controller.dart';
import 'package:get/instance_manager.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController(), fenix: true);
  }
}
