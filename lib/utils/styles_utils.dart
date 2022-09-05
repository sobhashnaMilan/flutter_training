import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool hasDebug = true;

Size setMediaQuery({required context}) => MediaQuery.of(context).size;

flutterPrint({required msg}) {
  return hasDebug ? debugPrint(msg) : "";
}

void showSuccessToast(BuildContext context, String message) {
  Fluttertoast.showToast(
    msg: message,
    textColor: Colors.white,
    backgroundColor: Colors.green,
    gravity: ToastGravity.BOTTOM,
    fontSize: MediaQuery.of(context).size.longestSide * 0.018,
  );
}

void showErrorToast(BuildContext context, String message) {
  Fluttertoast.showToast(
    msg: message,
    textColor: Colors.red,
    backgroundColor: Colors.green,
    gravity: ToastGravity.BOTTOM,
    fontSize: MediaQuery.of(context).size.longestSide * 0.018,
  );
}

bool nullCheck(dynamic d) {
  return d == null;
}
