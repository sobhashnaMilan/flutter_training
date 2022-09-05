import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screen/firebase_deep_linking/deep_link_firebase.dart';
import 'package:flutter_training/utils/styles_utils.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  /// get initState
  @override
  Future<void> onInit() async {
    super.onInit();

    /// app Terminated State
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) initDynamicLinks(initialLink);

    /// app Background / Foreground State
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      if (initialLink != null) initDynamicLinks(dynamicLinkData);
      flutterPrint(msg: 'deepLink Url');
    }).onError((error) {
      flutterPrint(msg: 'onLink error');
      flutterPrint(msg: error.message);
    });

    flutterPrint(msg: "on Init");
  }

  @override
  void onReady() {
    super.onReady();
    flutterPrint(msg: "on Ready");
  }

  void initDynamicLinks(PendingDynamicLinkData initialLink) {
    final Uri deepLink = initialLink.link;
    flutterPrint(msg: "deepLink" + deepLink.toString());
    Map<String, String> params = deepLink.queryParameters;
    String name = params['name'] ?? '';
    flutterPrint(msg: 'userId $name');
    Get.to(const DeepLinkFirebase(), arguments: name);
  }
}
