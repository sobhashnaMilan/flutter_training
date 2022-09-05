import 'dart:convert';

import 'package:flutter_training/util/import_export_util.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../helper_manager/network_manager/api_constant.dart';
import '../helper_manager/network_manager/remote_services.dart';
import '../models/home_model.dart';
import '../models/response_model.dart';

class ApiDemoController extends GetxController {
  // var userList = <UserModel>[].obs;
  var isDataLoading = false.obs, homeDataList = <Datum>[].obs;

  var message = StringConstant();

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

  /*userListAPICall({
    required onSuccess,
    required onError,
    required onRequestTimeOut,
  }) async {
    try {
      http.Response result = await ApiManager.userListCall(
        onRequestTimeOut: onRequestTimeOut,
      );
      if (result.statusCode == success) {
        var response = jsonDecode(result.body);
        Logger().d( response.toString());
        List<UserModel> list = response.map((e) => UserModel.fromJson(e as UserModel)).toList();
        for (var element in list) {
          userList.add(element);
        };
        userList.addAll(list.toList());
        onSuccess("SUCCESS");
      } else {
        var response = jsonDecode(result.body);
        onError(response['message']);
      }
    } catch (e) {
      Logger().d( "Error -> $e");
      onError(AppString().msgSomethingWrong);
    }
  }*/

  /*userAddAPICall({
    required name,
    required job,
    required onSuccess,
    required onError,
    required onRequestTimeOut,
  }) async {
    try {
      http.Response result = await ApiManager.userAddAPICall(
        name: name,
        job: job,
        onRequestTimeOut: onRequestTimeOut,
      );
      if (result.statusCode == created) {
        var response = jsonDecode(result.body);
        Logger().d( "Response -> $response");
        onSuccess("SUCCESS");
      } else {
        var response = jsonDecode(result.body);
        onError(response['message']);
      }
    } catch (e) {
      Logger().d( "Error -> $e");
      onError(AppString().msgSomethingWrong);
    }
  }*/
}
