import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_training/ui/firebase_deep_linking/deep_link_firebase.dart';
import 'package:flutter_training/util/app_logger.dart';
import 'package:get/get.dart';
import '../../helper_manager/network_manager/api_constant.dart';
import '../../helper_manager/network_manager/remote_services.dart';
import '../../models/home_model.dart';
import '../../models/response_model.dart';

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
      Logger().d("Error :: deepLink Url");
    }).onError((error) {
      Logger().d('onLink error');
      Logger().d(error.message);
    });

    Logger().d( "on Init");
  }

  @override
  void onReady() {
    super.onReady();
    Logger().d( "on Ready");
  }

  void initDynamicLinks(PendingDynamicLinkData initialLink) {
    final Uri deepLink = initialLink.link;
    Logger().d( "deepLink" + deepLink.toString());
    Map<String, String> params = deepLink.queryParameters;
    String name = params['name'] ?? '';
    Logger().d( 'userId $name');
    Get.to(const DeepLinkFirebase(), arguments: name);
  }

  var isDataLoading = false.obs, homeDataList = <Datum>[].obs;

  HomeModel? homeModel;

  updateLoadingFlag() {
    isDataLoading.value = !isDataLoading.value;
    update();
  }

  homeDataAPICall({
    required requestParams,
    required onError,
    required pullToRefresh,
  }) async {
    if (!pullToRefresh) updateLoadingFlag();

    // ResponseModel<HomeModel> homeAPIResponse = await sharedServiceManager.createPostRequest(endPoint: APIConstants.homeScreenDataEndPoint, requestParams: requestParams);
    ResponseModel<HomeModel> homeAPIResponse = await sharedServiceManager.createPostRequest(typeOfEndPoint: ApiType.home, params: requestParams);

    if (!pullToRefresh) updateLoadingFlag();

    if (homeAPIResponse.status == ApiConstant.statusCodeSuccess) {
      homeDataList.clear();
      homeModel = homeAPIResponse.data;
      homeDataList.value.addAll(homeModel?.data ?? []);
      update(homeDataList);
    } else {
      onError(homeAPIResponse.message);
    }
  }
}
