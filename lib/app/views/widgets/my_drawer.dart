import 'package:enter_tainer/app/views/modules/my_profile/setting/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/widgets/src/super_language_btn.dart';

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
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.only(
            top: 24,
            left: 16,
            right: 16,
            bottom: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Spacer(),

                  IconButton(
                    icon: const Icon(Icons.close, size: 36),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _DrawerIconButton(
                    onTap: () {
                      Get.to(() => FavouriteScreen());
                    },
                    icon: Icons.favorite_border,
                    label: 'المفضل',
                  ),
                  _DrawerIconButton(
                    icon: Icons.map_outlined,
                    label: 'الخريطة',
                    onTap: () {
                      Get.to(() => FavouriteScreen());
                    },
                  ),
                  _DrawerIconButton(
                    onTap: () {
                      Get.to(() => BuyOfferBottomSheet());
                    },
                    icon: Icons.shopping_cart_outlined,
                    label: 'شراء',
                  ),
                  _DrawerIconButton(
                    onTap: () {
                      Get.to(() => NotificationScreen());
                    },
                    icon: Icons.notifications_none,
                    label: 'التنبيهات',
                  ),
                  _DrawerIconButton(
                    onTap: () {
                      Get.to(() => CallUsBottomSheet());
                    },
                    icon: Icons.headset_mic_outlined,
                    label: 'اتصل بنا',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SuperLanguageBtn.text(
                    onChanged: () {
                      // controller.updateMyLanguage();
                      // controller.initHtmlPages();
                    },
                  ),
                  SettingRow(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, size: 32, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingRow extends StatelessWidget {
  const SettingRow({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(Settings()),
      child: Row(
        children: [
          const Icon(Icons.settings, size: 24, color: Color(0xff0E7167)),
          const SizedBox(width: 6),
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff0E7167),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
