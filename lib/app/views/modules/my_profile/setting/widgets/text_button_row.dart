// ignore_for_file: must_be_immutable
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/underlined_text.dart';
import 'package:flutter/material.dart';

class TextButtonRow extends StatelessWidget {
  String title;
  String buttonText;
  Color underlineTextColor;

  TextButtonRow({
    super.key,
    required this.title,
    required this.buttonText,
    this.underlineTextColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {},
          child: UnderlinedText(
            buttonText: buttonText,
            underlineTextColor: underlineTextColor,
          ),
        ),
      ],
    );
  }
}
