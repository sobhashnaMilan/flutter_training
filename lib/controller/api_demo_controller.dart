import 'dart:convert';

import 'package:flutter_training/utils/app_string.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Api/ApiConfig.dart';
import '../Api/ApiManager.dart';
import '../utils/styles_utils.dart';

class ApiDemoController extends GetxController {

  var userList = [].obs;

  var message = AppString();

  userListAPICall({
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
        flutterPrint(msg: response.toString());
        userList.addAll(response);
        onSuccess("SUCCESS");
      } else {
        var response = jsonDecode(result.body);
        onError(response['message']);
      }
    } catch (e) {
      flutterPrint(msg: "Error -> $e");
      onError(AppString().msgSomethingWrong);
    }
  }

  userAddAPICall({
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
        flutterPrint(msg: "Response -> $response");
        onSuccess("SUCCESS");
      } else {
        var response = jsonDecode(result.body);
        onError(response['message']);
      }
    } catch (e) {
      flutterPrint(msg: "Error -> $e");
      onError(AppString().msgSomethingWrong);
    }
  }
}
