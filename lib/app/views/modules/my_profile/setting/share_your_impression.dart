import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareYourImpression extends StatelessWidget {
  ShareYourImpression({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'انطباعك حول التطبيق',
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'يهمنا الاصغاء الى وجهة نظرك بهدف تحسين خدماتنا',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontFamily: GoogleFonts.cairo().fontFamily,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontFamily: GoogleFonts.cairo().fontFamily,
              ),
              decoration: InputDecoration(
                hintText: 'أخبرنا',
                hintStyle: TextStyle(
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  color: Colors.grey,
                ),
                prefixIcon: Directionality(
                  textDirection: TextDirection.rtl,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Color(0xff204CF5)),
                    onPressed: () {
                      final feedback = _controller.text.trim();
                      if (feedback.isNotEmpty) {
                        Get.snackbar(
                          '',
                          '',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Color(0xff204CF5),
                          colorText: Colors.white,
                          duration: const Duration(seconds: 2),
                          titleText: Text(
                            'شكراً لك!',
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          messageText: Text(
                            'تم إرسال انطباعك بنجاح',
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        );
                        _controller.clear();
                      } else {
                        Get.snackbar(
                          '',
                          '',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 2),
                          titleText: Text(
                            'تنبيه',
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          messageText: Text(
                            'يرجى كتابة انطباعك أولاً',
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              cursorColor: Colors.grey,
              cursorWidth: 3,
              cursorHeight: 18,
              minLines: 1,
              maxLines: null,
              autocorrect: true,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}
