import 'package:enter_tainer/app/views/modules/auth/forgetpass_view.dart';
import 'package:enter_tainer/app/views/modules/auth/user_type_selection_page.dart';
import 'package:get/get.dart';

import '../../app/views/modules/auth/login_screen.dart';
import '../../app/views/modules/auth/otp_verify_screen.dart';
import '../../app/views/modules/auth/register_screen.dart';
import '../../app/views/modules/auth/user_profile_screen.dart';
import '../../app/views/modules/home/screens/home_screen.dart';
import '../../app/views/modules/main_screen/main_screen.dart';
import '../../app/views/modules/others/contact_us_view.dart';
import '../../app/views/modules/others/no_connection_view.dart';
import '../../app/views/modules/splash/language_select_view.dart';
import '../../app/views/modules/splash/splash_view.dart';
import '../../app/views/modules/splash/welcome_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SELECT_USER_TYPE;

  static final routes = [
    GetPage(name: Routes.HOME, page: () => const HomeScreen()),
    GetPage(name: Routes.SPLASH, page: () => const SplashView()),
    GetPage(name: Routes.NOCONNECTION, page: () => const NoConnectionPage()),
    GetPage(name: Routes.WELCOME, page: () => WelcomeView()),
    GetPage(name: Routes.LanguageSelect, page: () => LanguageSelectView()),
    GetPage(name: Routes.CONTACTUS, page: () => const ContactUsPage()),
    GetPage(name: Routes.UserProfilePage, page: () => UserProfilePage()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.SIGNUP, page: () => RegisterPage()),
    GetPage(name: Routes.OTPVERIFY, page: () => OTPVerifyPage()),
    GetPage(name: Routes.MAIN, page: () => MainScreen()),
            GetPage(name: Routes.SELECT_USER_TYPE, page: () => SelectUserTypePage()), // ✅ جديد

  ];
}
