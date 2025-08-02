// lib/app/utils/logout_utils.dart
import 'package:enter_tainer/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


void showLogoutDialog(BuildContext context) {
  Get.dialog(
    AlertDialog(
      title: Text(
        'تسجيل الخروج',
        style: TextStyle(
          fontFamily: GoogleFonts.cairo().fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'هل أنت متأكد من أنك تريد تسجيل الخروج؟',
        style: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // إغلاق الـ dialog
          },
          child: Text(
            'إلغاء',
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(); // إغلاق الـ dialog
            performLogout(); // تنفيذ تسجيل الخروج
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text(
            'تسجيل الخروج',
            style: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
          ),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}

Future<void> performLogout() async {
  try {
    final AuthController authController = Get.find<AuthController>();
    await authController.logout();
  } catch (e) {
    print('Logout error: $e');
    Get.snackbar(
      'خطأ',
      'حدث خطأ أثناء تسجيل الخروج، حاول مرة أخرى',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
