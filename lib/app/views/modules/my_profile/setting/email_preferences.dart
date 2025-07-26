import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/email_preferences_controller.dart';

class EmailPreferencesScreen extends StatelessWidget {
  final EmailPreferencesController controller = Get.put(
    EmailPreferencesController(),
    permanent: true,
  );

  EmailPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff204CF5),
        elevation: 0,
        automaticallyImplyLeading: false,

        title: Text(
          'تفضيلات البريد الإلكتروني',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
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
          // Header image section
          Container(
            color: Colors.grey[200],
            // height: 200,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'asset/6664121.jpg',
                  fit: BoxFit.fill,
                  height: 200,
                  width: double.infinity,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16,
                    ),
                    child: Text(
                      'تحكم بطريقة التواصل المفضلة لديك',

                      style: TextStyle(
                        fontSize: 24,

                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content section
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main heading
                  SizedBox(height: 30),

                  // Question text
                  Text(
                    'ما الذي تود أن نتواصل معك بشأنه؟',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),

                  SizedBox(height: 20),

                  // First switch option
                  GetBuilder<EmailPreferencesController>(
                    builder:
                        (controller) => EmailRowWidget(
                          value: controller.switchOneState,
                          onChanged: (value) {
                            controller.toggleSwitchOne();
                          },
                          text: 'أحدث الأماكن والعروض',
                        ),
                  ),

                  Divider(color: Colors.grey[300], thickness: 1, height: 20),

                  // Second switch option
                  GetBuilder<EmailPreferencesController>(
                    builder:
                        (controller) => EmailRowWidget(
                          value: controller.switchTwoState,
                          onChanged: (value) {
                            controller.toggleSwitchTwo();
                          },
                          text: 'العروض والخصومات',
                        ),
                  ),
                  SizedBox(height: 20),
                  // Description text
                  Text(
                    'يستغرق تحديث نظامنا بتفضيلاتك حوالي 48 ساعة، لذلك من الممكن أن تستلم رسائل بريد إلكتروني إضافية منا.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),

                  Divider(color: Colors.grey[300], thickness: 1, height: 20),

                  // Footer note
                  Text(
                    'يرجى ملاحظة أن الرسائل المهمة المتعلقة بالمعاملات مثل تحديد الاشتراك والفواتير والإشعارات لن تتأثر في حال أختيار إلغاء الاشتراك في الرسائل الترويجية المذكورة أعلاه.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Divider(color: Colors.grey[300], thickness: 1, height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailRowWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String text;
  const EmailRowWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.black87),
          textAlign: TextAlign.right,
        ),
        Column(
          children: [
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xff204CF5),
            ),
            Text(
              'مشترك',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
}
