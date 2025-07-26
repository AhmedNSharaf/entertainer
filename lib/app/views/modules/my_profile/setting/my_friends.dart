import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'friends_list.dart';

class MyFriends extends StatelessWidget {
  const MyFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),

      appBar: AppBar(
        title: Text(
          'أصدقائي',
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
          const SizedBox(height: 30),
          SettingItem(
            title: 'لائحة الأصدقاء',
            onTap: () {
              // Handle tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FriendsList()),
              );
            },
            hasSwitch: false,
          ),
        ],
      ),
    );
  }
}
