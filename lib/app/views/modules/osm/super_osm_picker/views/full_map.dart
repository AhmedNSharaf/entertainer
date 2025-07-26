import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullMap extends StatelessWidget {
  final Function() onFullScreenPressed; // تمرير دالة عند الضغط

  const FullMap({super.key, required this.onFullScreenPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: FloatingActionButton(
              backgroundColor: Colors.white70,
              elevation: 10,
              onPressed: onFullScreenPressed,
              child: Icon(Icons.fullscreen, color: Get.theme.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
