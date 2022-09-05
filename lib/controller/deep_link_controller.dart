import 'package:flutter_training/utils/app_string.dart';
import 'package:get/get.dart';

class DeepLinkController extends GetxController {
  /// variable
  var deepLinkParameters = "".obs;
  var deepLinkQueryValue = "Params Value".obs;
  var linkMessage = "".obs;

  var message = AppString();

  @override
  void onInit() {
    var argumentsUri = Get.arguments;
    if (argumentsUri != null) {
      deepLinkQueryValue.value = argumentsUri;
    }
    else{
      deepLinkQueryValue.value = "Query value";
    }
    super.onInit();
  }
}
