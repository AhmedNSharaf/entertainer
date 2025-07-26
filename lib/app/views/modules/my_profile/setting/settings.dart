import 'package:enter_tainer/app/views/modules/my_profile/setting/products.dart';
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/countries_bottom_sheet.dart';
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/setting_item.dart';
import 'package:enter_tainer/core/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/notification_controller.dart';
import 'about_us_info_screen.dart';
import 'add_new_card_screen.dart';
import 'discount_history.dart';
import 'email_preferences.dart';
import 'help_and_support_screen.dart';
import 'my_family.dart';
import 'my_friends.dart';
import 'orders.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final NotificationController controller = Get.put(
    NotificationController(),
    permanent: true,
  );

  // bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        title: Text(
          'إعدادات',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            SettingItem(
              title: 'اللغة',
              subtitle: 'عربي',
              hasSwitch: false,
              onTap: () {
                // Handle language change
                showModalBottomSheet(
                  context: context,
                  builder: (context) => CountriesBottomSheet(),
                );
              },
            ),
            SettingItem(
              title: 'الموقع الجغرافي',
              subtitle: 'دبي والإمارات الشمالية',
              hasSwitch: false,
              onTap: () {
                // Handle location change
              },
            ),
            SettingItem(title: 'حسابي', hasSwitch: false, onTap: () {}),
            SettingItem(
              title: 'المحفظة',
              hasSwitch: false,
              onTap: () {
                Get.to(() => AddNewCardScreen());
              },
            ),
            const SizedBox(height: 40),

            SettingItem(
              title: 'عائلتي',
              hasSwitch: false,
              onTap: () {
                Get.to(() => MyFamily());
                // Handle family
              },
            ),
            SettingItem(
              title: 'أصدقائي',
              hasSwitch: false,
              onTap: () {
                // Handle friends
                Get.to(() => MyFriends());
              },
            ),
            const SizedBox(height: 40),

            SettingItem(
              title: 'المنتجات',
              hasSwitch: false,
              onTap: () {
                Get.to(() => Products());
                // Handle products
              },
            ),
            SettingItem(
              title: 'التحليلات والادخار',
              hasSwitch: false,
              onTap: () {
                // Handle analytics
              },
            ),
            SettingItem(
              title: 'عمليات الاستيراد',
              hasSwitch: false,
              onTap: () {
                // Handle import operations
              },
            ),
            SettingItem(
              title: 'سجل كود النظم',
              hasSwitch: false,
              onTap: () {
                Get.to(() => DiscountHistory());
                // Handle system code log
              },
            ),
            SettingItem(
              title: 'الطلبات',
              hasSwitch: false,
              onTap: () {
                Get.to(() => Orders());
                // Handle orders
              },
            ),
            SettingItem(
              title: 'الحجوزات',
              hasSwitch: false,
              onTap: () {
                // Handle rewards
              },
            ),
            const SizedBox(height: 40),

            GetBuilder<NotificationController>(
              builder:
                  (controller) => SettingItem(
                    title: 'الإشعارات',
                    hasSwitch: true,
                    value: controller.notificationsEnabled,
                    onSwitchChanged: (value) {
                      controller.toggleNotifications();
                    },
                  ),
            ),
            SettingItem(
              title: 'تفضيلات البريد الإلكتروني',
              hasSwitch: false,
              onTap: () {
                Get.to(() => EmailPreferencesScreen());

                // Handle email preferences
              },
            ),
            const SizedBox(height: 40),
            SettingItem(
              title: 'كيف يعمل التطبيق؟',
              hasSwitch: false,
              onTap: () {
                // Handle email preferences
              },
            ),
            SettingItem(
              title: 'المساعدة والدعم',
              hasSwitch: false,
              onTap: () {
                Get.to(() => HelpAndSupportScreen());
                // Handle email preferences
              },
            ),
            SettingItem(
              title: 'نبذة عن المنتج',
              hasSwitch: false,
              onTap: () {
                Get.to(() => AboutUsInfoScreen());
                // Handle email preferences
              },
            ),
            const SizedBox(height: 40),
            SettingItem(
              title: 'تسجيل الخروج',
              hasSwitch: false,
              textColor: Colors.red,
              onTap: () {
                Get.offAllNamed(Routes.SELECT_USER_TYPE);
                // Handle email preferences
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
