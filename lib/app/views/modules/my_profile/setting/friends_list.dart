import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/connect_friends_bottom_sheet.dart';
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اللائحة',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('asset/6664121.jpg'),
            const SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'يبدو أنك لم تقم باضافة أي أصدقاء بعد.',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'أضف الاصدقاء لترى من يوفر أكثر !',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              buttonText: 'إضافة صديق',
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  

                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: const ConnectFriendsBottomSheet(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
