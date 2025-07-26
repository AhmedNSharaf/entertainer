import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectFriendsBottomSheet extends StatelessWidget {
  const ConnectFriendsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'لديك أصدقاء يستخدمون إنترتينر؟',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                ),
                // const SizedBox(height: 8),
                Text(
                  'هل لديك أصدقاء يستخدمون إنترتينر؟ يمكنك أن تدعمهم للتواصل معك '
                  'وتعقب قيمة التوفير التي تحققها من خلال لوحة المستخدمين.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                _buildOption(context, 'العنوان الإلكتروني'),
                _buildOption(context, 'رسالة نصية'),
                _buildOption(context, 'فيسبوك'),
                _buildOption(context, 'واتساب'),
                _buildOption(context, 'مسنجر'),
              ],
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              Get.back(); // Close the bottom sheet
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Text(
                'إلغاء',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff204CF5),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String title) {
    return Column(
      children: [
        Divider(color: Colors.grey[300], thickness: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 26,
              fontFamily: GoogleFonts.cairo().fontFamily,
              color: const Color(0xff204CF5),
            ),
          ),
        ),
      ],
    );
  }
}
