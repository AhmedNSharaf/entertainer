import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscountHistory extends StatelessWidget {
  const DiscountHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'سجل كود الخصم',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/eye.png', height: 200, width: 200),
            const SizedBox(height: 100),
            Text(
              'لا يوجد سجل للخصومات حتى الآن',
              style: TextStyle(
                fontSize: 32,
                fontFamily: GoogleFonts.cairo().fontFamily,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'ستظهر جميع اكواد الخصم هنا بعد استخدامها',
              style: TextStyle(
                fontSize: 18,
                fontFamily: GoogleFonts.cairo().fontFamily,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
