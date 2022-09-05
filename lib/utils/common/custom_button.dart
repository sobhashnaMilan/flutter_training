import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;

  const CustomButton({Key? key, required this.onPress, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ElevatedButton(
            child: Text(text),
            onPressed: onPress,
          ),
        )
      ],
    );
  }
}
