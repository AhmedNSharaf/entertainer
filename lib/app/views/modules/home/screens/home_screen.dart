import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/widgets/src/super_scaffold.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../controllers/app_controller.dart';
import '../../../widgets/my_drawer.dart';
import '../../buy/buy.dart';
import '../../my_profile/my_profile_screen.dart';
import '../../main_screen/main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AppController controller = AppController.to;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      0.1.milliseconds.delay(() {
        bool b = controller.tabController == null;
        controller.tabController = TabController(length: 3, vsync: this);
        if (b) {
          controller.updateIndex(0);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SuperScaffold(
        onWillPop: controller.onWillPop,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Obx(() {
            return controller.tabController == null
                ? const SizedBox()
                : TabBarView(
                  controller: controller.tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    MainScreen(),
                    // DeliveryScreen(),
                    // AllOutletsScreen(),
                    BuyScreen(),
                    MyProfileScreen(),
                  ],
                );
          }),
        ),
        bottomNavigationBar: Obx(() {
          return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                enableFeedback: true,
                selectedFontSize: 12,
                unselectedFontSize: 11,
                selectedItemColor: AppColors.appMainColor,
                unselectedItemColor: Colors.grey[600],
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.appMainColor,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[600],
                ),
                items: [
                  _buildBottomNavigationItem(
                    iconData: Icons.home_rounded,
                    label: 'الرئيسية',
                    isSelected: controller.selectedBottomBarIndex == 0,
                  ),
                  // _buildBottomNavigationItem(
                  //   iconData: Icons.local_shipping_rounded,
                  //   label: 'التوصيل',
                  //   isSelected: controller.selectedBottomBarIndex == 1,
                  // ),
                  // _buildBottomNavigationItem(
                  //   iconData: Icons.store_mall_directory_rounded,
                  //   label: 'جميع المنافذ',
                  //   isSelected: controller.selectedBottomBarIndex == 2,
                  // ),
                  _buildBottomNavigationItem(
                    iconData: Icons.shopping_cart_rounded,
                    label: 'شراء',
                    isSelected: controller.selectedBottomBarIndex == 1,
                  ),
                  _buildBottomNavigationItem(
                    iconData: Icons.person_rounded,
                    label: 'حسابي',
                    isSelected: controller.selectedBottomBarIndex == 2,
                  ),
                ],
                onTap: controller.onNavigateBtnTap,
                currentIndex: controller.selectedBottomBarIndex,
              ),
            ),
          );
        }),
        drawer: const MyDrawer(),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationItem({
    required IconData iconData,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.appMainColor.withOpacity(0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          iconData,
          size: 24,
          color: isSelected ? AppColors.appMainColor : Colors.grey[600],
        ),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.appMainColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(iconData, size: 24, color: AppColors.appMainColor),
      ),
      label: label,
    );
  }

  @override
  void dispose() {
    controller.tabController?.dispose();
    controller.tabController = null;
    super.dispose();
  }
}

// Alternative modern style - you can use this instead if you prefer a more modern look
BottomNavigationBarItem getModernBottomNavigationItem({
  required IconData iconData,
  required String label,
  required bool isSelected,
}) {
  return BottomNavigationBarItem(
    icon: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? AppColors.appMainColor.withOpacity(0.15)
                    : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            size: 22,
            color: isSelected ? AppColors.appMainColor : Colors.grey[600],
          ),
        ),
        const SizedBox(height: 2),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 2,
          width: isSelected ? 20 : 0,
          decoration: BoxDecoration(
            color: AppColors.appMainColor,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    ),
    label: label,
  );
}
