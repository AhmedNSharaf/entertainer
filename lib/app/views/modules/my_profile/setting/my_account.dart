import 'package:enter_tainer/app/views/modules/my_profile/setting/select_product_bottom_sheet.dart';
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/build_icon_button.dart';
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/build_menu_item.dart';
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/card_swiper.dart';
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/savings_leaderboard.dart';
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/text_button_row.dart';
import 'package:flutter/material.dart';

import 'analytics.dart';

class ProfileDashboardScreen extends StatelessWidget {
  const ProfileDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final double top = constraints.biggest.height;
                // Normalize value between 0 and 1 for animation
                final double shrinkFactor =
                    (top - kToolbarHeight) / (250 - kToolbarHeight);

                return Stack(
                  children: [
                    // Background
                    Container(color: Colors.white),

                    // Fixed Settings Icon
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 12,
                      left: 16,
                      child: Icon(
                        Icons.settings_outlined,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),

                    // Animated Profile Image Icon
                    Positioned(
                      top:
                          12 * shrinkFactor +
                          MediaQuery.of(context).padding.top,
                      right: 16,
                      child: CircleAvatar(
                        radius: 24 * shrinkFactor + 16, // animate from 40 to 16
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.image_outlined,
                          size: 24 * shrinkFactor + 8, // animate from 32 to 8
                          color: Colors.grey[600],
                        ),
                      ),
                    ),

                    // Name, email, and button (fade and shrink)
                    Positioned(
                      top:
                          100 * shrinkFactor +
                          MediaQuery.of(context).padding.top,
                      right: 16,
                      left: 16,
                      bottom: 16,
                      child: Opacity(
                        opacity: shrinkFactor.clamp(0.0, 1.0),
                        child: Transform.scale(
                          scale: shrinkFactor.clamp(0.8, 1.0),
                          alignment: Alignment.bottomRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Ahmed Nabil",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "ahmednabilwww378@gmail.com",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              GestureDetector(
                                onTap: () {},
                                child: IntrinsicWidth(
                                  child: Column(
                                    children: [
                                      Text(
                                        "نبذة عني",
                                        style: TextStyle(
                                          color: Colors.blue[800],
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        height: 2,
                                        width: double.infinity,
                                        color: Colors.blue[800],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Four icon buttons row
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BuildIconButton(
                        icon: Icons.receipt_long_outlined,
                        label: 'عمليات الاستيراد',
                      ),
                      BuildIconButton(
                        icon: Icons.shopping_bag_outlined,
                        label: 'الطلبات',
                      ),
                      BuildIconButton(
                        icon: Icons.store_outlined,
                        label: 'المنتجات',
                      ),
                      BuildIconButton(
                        icon: Icons.account_balance_wallet_outlined,
                        label: 'المحفظة',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Divider(color: Colors.grey[300]),
                // Menu items
                BuildMenuItem(
                  title: 'تفضيلاتي',
                  label: '20%',
                  backgroundColor: Colors.red.withOpacity(0.2),
                  widget: null,
                ),
                Divider(color: Colors.grey[300]),
                BuildMenuItem(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Analytics(),
                      ),
                    );
                  },
                  title: 'التحليلات والادخار',
                  label: '',
                  backgroundColor: null,
                  widget: Image.asset('asset/bar-chart.png', width: 24),
                ),
                Divider(color: Colors.grey[300]),

                BuildMenuItem(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const ProductBottomSheet(),
                    );
                  },
                  title: 'إهداء لصديق',
                  label: '',
                  backgroundColor: null,
                  widget: Icon(Icons.card_giftcard_outlined),
                ),
                Divider(color: Colors.grey[300]),

                // Savings dashboard section
                SavingsLeaderBoard(),

                // Start saving section
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButtonRow(
                          title: 'ابدأ التوفير مع',
                          buttonText: 'اظهار الكل',
                        ),

                        SizedBox(height: 16),
                        CardSwiper(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
