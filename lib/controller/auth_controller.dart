import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/utils/app_string.dart';
import 'package:flutter_training/utils/styles_utils.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  /// variable
  var otp = "".obs;
  var verificationId = "".obs;
  var resendToken = 0.obs;
  var number = "".obs;
  var deepLinkParameters = "".obs;

  var message = AppString();
  var textController = TextEditingController();
  var otpController = TextEditingController();

  late PhoneAuthCredential phoneAuthCredential;
  late AuthCredential authCredential;
  late UserCredential userCredential;


  RxBool validation(BuildContext context) {
    if (textController.text.isEmpty) {
      showErrorToast(context, message.msgEmptyNumber);
      return false.obs;
    } else if (textController.text.length != 10) {
      showErrorToast(context, message.msgValidNumber);
      return false.obs;
    } else {
      return true.obs;
    }
  }
}
