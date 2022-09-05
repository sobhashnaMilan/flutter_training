import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screen/firebase_authentication/otp_login.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../utils/styles_utils.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var authController = Get.put(AuthController());
  FirebaseAuth auth = FirebaseAuth.instance;

  /// screen data
  var arguments = Get.arguments;
  var isResend = true;

  @override
  void initState() {
    super.initState();
    flutterPrint(msg: "number -> ${arguments[0]}");
    authController.number.value = arguments[0];
    _verifyNumber();
  }

  /// auth verify PhoneNumber

  Future<void> _verifyNumber() async {
    await auth.verifyPhoneNumber(
      phoneNumber: authController.number.value,
      verificationCompleted: (PhoneAuthCredential credential) async {
        flutterPrint(msg: 'verificationCompleted ----------------->');

        /// auto verify PhoneNumber in android only

        await auth
            .signInWithCredential(credential)
            .then((value) => _logIn())
            .catchError((e) => flutterPrint(msg: "error -> $e"));
      },
      verificationFailed: (FirebaseAuthException e) {
        flutterPrint(msg: 'FirebaseAuthException -> $e');
      },
      codeSent: (String verificationId, int? resendToken) {
        authController.verificationId.value = verificationId;
        authController.resendToken.value = resendToken!;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        flutterPrint(msg: 'Timeout -> $verificationId');
      },
    );
  }

  /// ReSend code

  Future<void> _reSend() async {
    await auth.verifyPhoneNumber(
      phoneNumber: authController.number.value,
      verificationCompleted: (PhoneAuthCredential credential) async {
        flutterPrint(msg: 'verificationCompleted -----------> ');

        /// auto verify PhoneNumber in android only

        await auth
            .signInWithCredential(credential)
            .then((value) => _logIn())
            .catchError((e) => flutterPrint(msg: "error -> $e"));
      },
      verificationFailed: (FirebaseAuthException e) {
        flutterPrint(msg: 'FirebaseAuthException -> $e');
      },
      codeSent: (String verificationId, int? resendToken) {
        authController.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        flutterPrint(msg: 'Timeout -> $verificationId');
      },
    );
  }

  /// check otp [submit otp]

  Future<void> _submitOTP(String smsCode) async {
    flutterPrint(msg: "otp -> $smsCode");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: authController.verificationId.value, smsCode: smsCode);

    await auth
        .signInWithCredential(credential)
        .then((value) => _logIn())
        .catchError((e) => flutterPrint(msg: "error -> $e"));
  }

  /// get current user

  void _logIn() async {
    var user = auth.currentUser;
    flutterPrint(msg: "login check -> ${user?.phoneNumber}");
    Get.off(const OtpLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(authController.message.appName),
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Text(
                    authController.message.txtOtpView,
                    style: const TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  TextField(
                    controller: authController.otpController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: authController.message.hintEnterOtp),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                ],
              ),
            )),
            ElevatedButton(
                onPressed: () {
                  _submitOTP(authController.otpController.text.isNotEmpty
                      ? authController.otpController.text
                      : authController.message.msgEmptyOtp);
                },
                child: Text(authController.message.btnVerify)),
            ElevatedButton(
                onPressed: () {
                  _reSend();
                },
                child: Text(authController.message.btnResend))
          ],
        ),
      ),
    );
  }
}
