import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'منتجات',
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 100),
              Image.asset('asset/not_found.png', height: 260, width: 260),
              SizedBox(height: 100),
              Text(
                textAlign: TextAlign.right,
                'يبدو انك لا تمتلك منتجا من انترتينر بعد',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  'ابدا التوفير اليوم مع الالاف من عروض 2 بسعر 1 وغيرها على الاكل والترفيه والصالونات والسبا وغيرها.',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CustomButton(buttonText: 'القاء نظرة', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
