import 'dart:async';
import 'package:enter_tainer/app/controllers/auth_controller.dart';
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
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ✅ تسجيل الكونترولرز
  Get.put<AppController>(AppController(), permanent: true);
  Get.put<LanguageService>(LanguageService(), permanent: true);
  Get.put<ThemeService>(ThemeService(), permanent: true);
  Get.put<ApiService>(ApiService(), permanent: true);
  Get.put<FavoritesController>(FavoritesController(), permanent: true);
  Get.put<SuperNotificationService>(SuperNotificationService(), permanent: true);

  // ✅ تسجيل AuthController والتحقق من حالة تسجيل الدخول
  final authController = Get.put<AuthController>(AuthController(), permanent: true);
  final bool isLoggedIn = await authController.checkLoginStatus();
  final String? userType = await authController.getSavedUserType();

  // ✅ تحديد المسار الابتدائي بناءً على حالة الدخول
  final String initialRoute = isLoggedIn ? userType=="customer" ? Routes.HOME :Routes.PROVIDER:AppPages.INITIAL ;

  runApp(MainApp(initialRoute: initialRoute));
}

class MainApp extends StatelessWidget {
  final String initialRoute;
  const MainApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return SuperMainApp(
      title: AppConstants.appName,

      /// Routing
      initialRoute: initialRoute,
      getPages: AppPages.routes,

      /// Themes
      lightTheme: AppThemes.lightTheme,

      /// Localization
      supportedLocales: const <Locale>[Locale('ar'), Locale('en')],
      translations: AppTranslations(),
    );
  }
}
