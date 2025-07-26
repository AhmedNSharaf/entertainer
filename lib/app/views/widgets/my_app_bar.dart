import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/image_utils/src/super_imageview.dart';
import 'package:neuss_utils/utils/constants.dart';
import 'package:neuss_utils/utils/helpers.dart';
import 'package:neuss_utils/utils/my_extensions.dart';
import 'package:neuss_utils/widgets/src/txt.dart';

import '../../../core/routes/app_pages.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../controllers/app_controller.dart';

class MyAppBar extends GetView<AppController> implements PreferredSizeWidget {
  const MyAppBar({super.key, this.title});

  final String? title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            // centerTitle: true,
            title: title == null
                ? SuperImageView(
                    imgAssetPath: AppAssets.appIcon,
                    width: 0.6.w,
                  )
                : Txt(
                    title,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Get.theme.primaryColor,
                  ),
            actions: [
              // InkWell(
              //   onTap: () {
              //     Get.toNamed(Routes.Notifications);
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //     child: Obx(() {
              //       int cnt = controller.myNotificationsList.where((element) => element.seen == false && element.userID != null).length;
              //       return Badge(
              //         label: Txt(
              //           cnt,
              //           fontSize: 16,
              //         ),
              //         largeSize: 20,
              //         isLabelVisible: cnt > 0,
              //         alignment: Alignment.topRight,
              //         child: const Icon(Icons.notifications, size: 30),
              //       );
              //     }),
              //   ),
              // ),
            ],
          ),
          InkWell(
            onTap: () {
              mShowToast('Map');
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.map_sharp, color: AppColors.appMainColor),
                  hSpace8,
                  Txt('Asafra Dakahlia', color: AppColors.appMainColor, fontSize: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40);
}
