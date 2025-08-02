import 'package:enter_tainer/app/controllers/auth_controller.dart';
import 'package:enter_tainer/app/views/modules/my_profile/products_screen.dart';
import 'package:enter_tainer/app/views/modules/my_profile/setting/settings.dart';
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/underlined_text.dart';
import 'package:enter_tainer/app/views/modules/my_profile/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'about_me.dart';
import 'analysis_save_screen.dart';
import 'esterad_screen.dart';
import 'my_favourites.dart';
import 'order_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final AuthController authController = Get.find<AuthController>();

  bool isScrolled = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scroll) {
              if (scroll.metrics.pixels > 20 && !isScrolled) {
                setState(() => isScrolled = true);
              } else if (scroll.metrics.pixels <= 20 && isScrolled) {
                setState(() => isScrolled = false);
              }
              return false;
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.settings, size: 45),
                          onPressed: () {
                            Get.to(() => Settings());
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          bool isWide = constraints.maxWidth > 360;
                          if (isWide && !isScrolled) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Text(
                                          authController.userName.value,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Obx(
                                        () => Text(
                                          authController.userEmail.value,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => const AboutMeScreen());
                                        },
                                        child: UnderlinedText(
                                          buttonText: 'نبذة عنى',
                                          underlineTextColor: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Omar Ragab',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'omarragab712000@gmail.com',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const AboutMeScreen());
                                  },
                                  child: const Text(
                                    'نبذة عني',
                                    style: TextStyle(
                                      color: Color(0xff204cf5),
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ProfileIcon(
                          onTap: () {
                            Get.to(() => const EsteradScreen());
                          },
                          title: 'عمليات الاسترداد',
                          icon: Icons.receipt_long_outlined,
                        ),
                        _ProfileIcon(
                          title: 'الطلبات',
                          onTap: () {
                            Get.to(() => const OrderScreen());
                          },
                          icon: Icons.shopping_bag_outlined,
                        ),
                        _ProfileIcon(
                          title: 'المنتجات',
                          onTap: () {
                            Get.to(() => const ProductsScreen());
                          },
                          icon: Icons.phone_android_outlined,
                        ),
                        _ProfileIcon(
                          title: 'المحفظة',
                          onTap: () {
                            Get.to(() => const WalletScreen());
                          },
                          icon: Icons.account_balance_wallet_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Profile ListTiles with Divider
                    _ProfileListTile(
                      onTap: () {
                        Get.to(() => const MyFavourites());
                      },
                      icon: Icons.favorite_border,
                      title: 'تفضيلاتي',
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '0%',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      hideIcon: true,
                    ),
                    // Divider(),
                    _ProfileListTile(
                      icon: Icons.bar_chart,
                      title: 'التحليلات والادخار',
                      onTap: () {
                        Get.to(() => const AnalysisSaveScreen());
                      },
                    ),
                    _ProfileListTile(
                      onTap: () {
                        Get.to(() => const MyFavourites());
                      },
                      icon: Icons.card_giftcard,
                      title: 'إهداء لصديق',
                    ),
                    const SizedBox(height: 8),
                    // Row(
                    //   children: [
                    //     Text(
                    //       'لوحة صدارة المدخرات',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 18,
                    //       ),
                    //     ),
                    //     Spacer(),
                    //     UnderlinedText(
                    //       buttonText: 'إدارة الأعضاء',
                    //       underlineTextColor: Color(0xff204cf5),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 8),
                    // Container(
                    //   width: double.infinity,
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 12,
                    //     vertical: 10,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Color(0xff204cf5).withOpacity(0.08),
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Text(
                    //             'أنت',
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //           SizedBox(width: 8),
                    //           Text('😃', style: TextStyle(fontSize: 28)),
                    //         ],
                    //       ),

                    //       Text(
                    //         '0 دولار أمريكي',
                    //         style: TextStyle(
                    //           color: Color(0xff204cf5),
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 24),
                    // Offers section
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'ابدأ التوفير مع',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 18,
                    //       ),
                    //     ),
                    //     UnderlinedText(
                    //       buttonText: 'إظهار الكل',
                    //       underlineTextColor: Color(0xff204cf5),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 12),
                    // // Offer card
                    // _OfferCard(),
                    // const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const _ProfileIcon({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 👈 تنفيذ الدالة عند الضغط
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final bool hideIcon;
  final VoidCallback? onTap; // 👈 جديد

  const _ProfileListTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.hideIcon = false,
    required this.onTap, // 👈 جديد
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) trailing!,
          if (!hideIcon) ...[
            const SizedBox(width: 4),
            Icon(icon, color: Colors.black54),
          ],
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap, // 👈 هنا استخدمنا الفانكشن الممررة
    );
  }
}

class _OfferCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // Expanded content first (right side in RTL)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'the ENTERTAINER',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'إنترتينر دبي 2025',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        'USD 170.18',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'USD 115.72',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  // Text(
                  //   'يشمل ضريبة القيمة المضافة',
                  //   style: TextStyle(fontSize: 9, color: Colors.grey[600]),
                  // ),
                  // Text(
                  //   'العضوية سارية حتى 30 ديسمبر 2025',
                  //   style: TextStyle(fontSize: 9, color: Colors.grey[600]),
                  // ),
                ],
              ),
            ),
          ),
          // Image on the left (LTR)
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.asset(
              'assets/images/app_icon.png',
              width: Get.width * 0.4,
              height: Get.height * 0.2,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
