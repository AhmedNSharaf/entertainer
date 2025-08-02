import 'package:enter_tainer/app/views/modules/my_profile/setting/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/widgets/src/super_language_btn.dart';
import 'dart:math' as math;

import '../modules/Drawer/Notification/notification_screen.dart';
import '../modules/Drawer/call_us.dart';
import '../modules/Drawer/favourites/favourite_screen.dart';
import 'buy_offer_bottom_sheet.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.grey.shade50],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.only(
            top: 40,
            left: 20,
            right: 20,
            bottom: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with close button
              _buildHeader(context),
              const SizedBox(height: 24),

              // Circular icons layout
              _buildCircularIconsLayout(),
              const SizedBox(height: 20),

              // Divider
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.grey.shade300,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Bottom row with language and settings
              _buildBottomRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo or app name (optional)
        const Text(
          'القائمة الرئيسية',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff0E7167),
          ),
        ),

        // Close button
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: IconButton(
            icon: const Icon(Icons.close_rounded, size: 28, color: Colors.grey),
            onPressed: () => Navigator.of(context).pop(),
            padding: const EdgeInsets.all(8),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularIconsLayout() {
    final List<Map<String, dynamic>> icons = [
      {
        'icon': Icons.favorite_rounded,
        'label': 'المفضل',
        'color': Colors.red.shade400,
        'onTap': () {
          Get.back();
          Get.to(() => FavouriteScreen());
        },
      },
      {
        'icon': Icons.map_rounded,
        'label': 'الخريطة',
        'color': Colors.blue.shade400,
        'onTap': () {
          Get.back();
          // Add map navigation here
        },
      },
      {
        'icon': Icons.shopping_cart_rounded,
        'label': 'شراء',
        'color': Colors.orange.shade400,
        'onTap': () {
          Get.back();
          Get.to(() => BuyOfferBottomSheet());
        },
      },
      {
        'icon': Icons.notifications_rounded,
        'label': 'التنبيهات',
        'color': Colors.purple.shade400,
        'onTap': () {
          Get.back();
          Get.to(() => NotificationScreen());
        },
      },
      {
        'icon': Icons.headset_mic_rounded,
        'label': 'اتصل بنا',
        'color': Colors.green.shade400,
        'onTap': () {
          Get.back();
          Get.to(() => CallUsBottomSheet());
        },
      },
    ];

    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        children: [
          // Background circle
          Center(
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xff0E7167).withOpacity(0.1),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
          ),
          // Positioned icons in circle
          ...List.generate(icons.length, (index) {
            final angle = (2 * math.pi * index / icons.length) - (math.pi / 2);
            final radius = 90.0;
            final x =
                125 +
                radius * math.cos(angle) -
                32; // 32 is half of icon container width
            final y =
                125 +
                radius * math.sin(angle) -
                32; // 32 is half of icon container height

            return AnimatedPositioned(
              duration: Duration(milliseconds: 300 + (index * 100)),
              left: x,
              top: y,
              child: _DrawerIconButton(
                icon: icons[index]['icon'],
                label: icons[index]['label'],
                color: icons[index]['color'],
                onTap: icons[index]['onTap'],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Language button with improved styling
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SuperLanguageBtn.text(
            onChanged: () {
              // controller.updateMyLanguage();
              // controller.initHtmlPages();
            },
          ),
        ),

        // Settings button with improved styling
        const SettingRow(),
      ],
    );
  }
}

class _DrawerIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _DrawerIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = const Color(0xff0E7167),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        tween: Tween(begin: 1.0, end: 1.0),
        builder: (context, scale, child) {
          return Transform.scale(scale: scale, child: child);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.15), color.withOpacity(0.08)],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withOpacity(0.3), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, size: 28, color: color),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingRow extends StatelessWidget {
  const SettingRow({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
        Get.to(() => Settings());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xff0E7167).withOpacity(0.1),
              const Color(0xff0E7167).withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xff0E7167).withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff0E7167).withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.settings_rounded,
              size: 20,
              color: const Color(0xff0E7167),
            ),
            const SizedBox(width: 8),
            const Text(
              'الإعدادات',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff0E7167),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
