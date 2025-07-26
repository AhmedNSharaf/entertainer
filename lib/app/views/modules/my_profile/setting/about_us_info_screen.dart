import 'package:enter_tainer/app/views/modules/my_profile/setting/share_your_impression.dart';
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsInfoScreen extends StatelessWidget {
  const AboutUsInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        title: Text(
          'معلومات عنا',
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
          const SizedBox(height: 40),
          SettingItem(
            title: 'اتفاقية ترخيص المستخدم النهائى',
            hasSwitch: false,
          ),
          SettingItem(
            title: 'شاركنا انطباعاتك',
            hasSwitch: false,
            onTap: () => Get.to(() => ShareYourImpression()),
          ),
          SettingItem(
            title: 'صنف التطبيق',
            hasSwitch: false,
            onTap: launchPlayStore,
          ),
        ],
      ),
    );
  }
}

void launchPlayStore() async {
  final Uri url = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.theentertainerme.entertainer',
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
