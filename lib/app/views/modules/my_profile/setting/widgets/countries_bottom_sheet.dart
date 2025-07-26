import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';

class CountriesBottomSheet extends StatefulWidget {
  const CountriesBottomSheet({super.key});

  @override
  State<CountriesBottomSheet> createState() => _CountriesBottomSheetState();
}

class _CountriesBottomSheetState extends State<CountriesBottomSheet> {
  String selectedLanguage = 'العربية'; // Default to Arabic

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black87),
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      textAlign: TextAlign.end,
                      'ابحث عن العروض من خلال الموقع',
                      style: TextStyle(
                        fontFamily: GoogleFonts.cairo().fontFamily,

                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text(
                'English',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
              trailing: Image.asset('asset/flag.png', width: 32, height: 32),
              leading: selectedLanguage == 'English'
                  ? const Icon(
                      Icons.check_circle,
                      color: Color.fromARGB(255, 45, 0, 221),
                    )
                  : const SizedBox(width: 24),
              onTap: () {
                setState(() {
                  selectedLanguage = 'English';
                });
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'العربية',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
              trailing: Image.asset(
                'asset/united-arab-emirates (1).png',
                width: 32,
                height: 32,
              ),
              leading: selectedLanguage == 'العربية'
                  ? const Icon(
                      Icons.check_circle,
                      color: Color.fromARGB(255, 45, 0, 221),
                    )
                  : const SizedBox(width: 24),
              onTap: () {
                setState(() {
                  selectedLanguage = 'العربية';
                });
              },
            ),
            // Add more countries as needed
          ],
        ),
      ),
    );
  }
}
