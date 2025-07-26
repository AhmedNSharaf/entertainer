import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFamily extends StatelessWidget {
  const MyFamily({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'عائلتى',
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff204CF5),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Image.asset('asset/6664121.jpg'),
          Text(
            'ليس لديك أي دعوات حتى الان',
            style: TextStyle(
              fontSize: 26,
              fontFamily: GoogleFonts.cairo().fontFamily,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
