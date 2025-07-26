import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:neuss_utils/image_utils/src/super_imageview.dart';
import 'package:neuss_utils/utils/my_extensions.dart';
import 'package:neuss_utils/widgets/src/txt.dart';

import '../../../../core/routes/app_pages.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../controllers/app_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  transitFunction() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    // Get.offAllNamed(Routes.WELCOME);
    // Get.offAllNamed(Routes.LOGIN);

    AppController controller = AppController.to;
    Get.offAllNamed(controller.successfullyLoggedIn ? Routes.HOME : Routes.LanguageSelect);
    if (!controller.isConnected) {
      Get.offAllNamed(Routes.NOCONNECTION);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: const Color(0xFF00052D),
      body: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SuperImageView(
                      imgAssetPath: AppAssets.appIcon,
                      width: 0.5.w,
                      fit: BoxFit.fitWidth,
                    ).animate(onComplete: (s) {
                      // mPrint('Animation is onComplete');
                      transitFunction();
                    }).fadeOut(curve: Curves.easeIn, delay: 100.ms, duration: 2900.ms),
                    SizedBox(
                      width: 0.3.w,
                      height: 20,
                      child: const LoadingIndicator(
                        indicatorType: Indicator.ballPulse,
                        colors: [AppColors.appMainColor],
                        strokeWidth: 1,
                        backgroundColor: Colors.white,
                        pathBackgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Txt('Powered by @Neuss for App Development', color: AppColors.appMainColor),
          ],
        ),
      ),
    );
  }
}
