import 'package:flutter/material.dart';
import 'package:flutter_training/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_training/screen/firebase_authentication/otp_screen.dart';

import '../../utils/common/app_bar.dart';

class FireBaseAuth extends StatefulWidget {
  const FireBaseAuth({Key? key}) : super(key: key);

  @override
  State<FireBaseAuth> createState() => _FireBaseAuthState();
}

class _FireBaseAuthState extends State<FireBaseAuth> {
  var authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    authController.textController.text = "1234567890";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(toolbarText: "Firebase Auth"),
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
                    authController.message.txtEnterNumber,
                    style: const TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  TextField(
                    controller: authController.textController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: authController.message.hintEnterNumber),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                ],
              ),
            )),
            ElevatedButton(
                onPressed: () {
                  validation();
                },
                child: Text(authController.message.btnOk))
          ],
        ),
      ),
    );
  }

  /// check validations

  void validation() {
    if (authController.validation(context).value) {
      var number = "+91" + authController.textController.text;
      Get.to(const OtpScreen(), arguments: [number]);
    }
  }
}
