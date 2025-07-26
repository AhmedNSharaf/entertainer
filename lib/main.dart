import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/controllers/favourite_controller.dart';
import 'core/services/super_notification_service.dart';
import 'package:neuss_utils/home/home.dart';
import 'app/controllers/app_controller.dart';
import 'core/repositories/api_service.dart';
import 'core/routes/app_pages.dart';
import 'core/utils/app_constants.dart';
import 'core/utils/app_themes.dart';
import 'core/utils/app_translations.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TxtManager.defaultColor = AppColors.appMainTextColor;
  await GetStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put<AppController>(AppController(), permanent: true);
  Get.put<LanguageService>(LanguageService(), permanent: true);
  Get.put<ThemeService>(ThemeService(), permanent: true);
  Get.put<ApiService>(ApiService(), permanent: true);
  Get.put<FavoritesController>(FavoritesController(), permanent: true);
  Get.put<SuperNotificationService>(
    SuperNotificationService(),
    permanent: true,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperMainApp(
      title: AppConstants.appName,

      ///region Routing
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,

      ///endregion Routing

      ///region Themes
      lightTheme: AppThemes.lightTheme,

      ///endregion Themes

      ///region Locales
      supportedLocales: const <Locale>[Locale('ar'), Locale('en')],
      translations: AppTranslations(),

      ///endregion Locales
    );
  }
}
