import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

class OtpLogin extends StatefulWidget {
  const OtpLogin({Key? key}) : super(key: key);

  @override
  State<OtpLogin> createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  var authController = Get.put(AuthController());
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(authController.message.appName),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Sign In ${auth.currentUser?.phoneNumber}",style: const TextStyle(fontSize: 30),),
          ElevatedButton(
              onPressed: () {
                auth.signOut();
                Get.back();
              },
              child: const Text('Sign Out'))
        ]),
      ),
    );
  }
}
