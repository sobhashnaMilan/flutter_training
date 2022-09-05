import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar({Key? key, required this.toolbarText}) : super(key: key);

  // CustomAppBar({Key? key, required this.chkText}) : super(key: key);
  // Function chkText;

  String toolbarText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      height: preferredSize.height,
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        toolbarText,
        style: const TextStyle(
            fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// app bar text fields
  /*@override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: TextField(onChanged: (value) {
        chkText(value);
      }),
    );
  }*/

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
