import 'package:flutter/material.dart';

class UnderlinedText extends StatelessWidget {
  const UnderlinedText({
    super.key,
    required this.buttonText,
    required this.underlineTextColor,
  });

  final String buttonText;
  final Color underlineTextColor;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonText,
            style: TextStyle(
              fontSize: 16,
              color: underlineTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 2,
            width: double.infinity,
            color: underlineTextColor,
          ),
        ],
      ),
    );
  }
}
