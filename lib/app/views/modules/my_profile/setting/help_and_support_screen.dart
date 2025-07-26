import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      // appBar: AppBar(
      appBar: AppBar(
        title: Text(
          'المساعدة والدعم',
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontWeight: FontWeight.bold,
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
          const SizedBox(height: 30),
          SettingItem(title: 'مساعدة ومحادثات فورية', hasSwitch: false),
          SettingItem(title: 'قواعد الاستخدام', hasSwitch: false),
          SettingItem(title: 'قواعد الاستخدام للفنادق', hasSwitch: false),
        ],
      ),
    );
  }
}
