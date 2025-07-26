import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.hasSwitch,
    this.value = false,
    this.onSwitchChanged,
    this.onTap,
    this.textColor,
  });

  final String title;
  final String? subtitle;
  final bool hasSwitch;
  final bool value;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback? onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: InkWell(
              onTap: hasSwitch ? null : onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              color: textColor ?? Colors.black,
                            ),
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              '($subtitle)',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: GoogleFonts.cairo().fontFamily,
                                fontWeight: FontWeight.w900,
                                color: textColor ?? Colors.black,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (hasSwitch)
                      Switch(
                        activeColor: Colors.white,
                        activeTrackColor: const Color(0xff204CF5),
                        value: value,
                        onChanged: onSwitchChanged,
                      )
                    else
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
            margin: const EdgeInsets.only(right: 16),
          ),
        ],
      ),
    );
  }
}
