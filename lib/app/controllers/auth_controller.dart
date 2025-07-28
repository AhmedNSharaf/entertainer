import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enter_tainer/core/routes/app_pages.dart';
import 'package:enter_tainer/core/services/auth_service.dart';
import 'package:enter_tainer/app/views/modules/auth/otp_verify_screen.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final Rxn<Map<String, dynamic>> currentUser = Rxn<Map<String, dynamic>>();
  final RxBool isResending = false.obs;

  // ✅ تغيير userEmail ليكون قابل للتعديل
  final RxString userEmail = ''.obs;

  void _showLoadingDialog() {
    if (!Get.isDialogOpen!) {
      Get.dialog(
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('يرجى الانتظار...', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  void _hideLoadingDialog() {
    try {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    } catch (e) {
      print('Error hiding loading dialog: $e');
    }
  }

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      _showLoadingDialog();

      final success = await _authService.registerUser(
        username: username,
        email: email,
        password: password,
      );

      if (success) {
        // ✅ حفظ البريد الإلكتروني
        userEmail.value = email;
        await _saveUserEmail(email);

        Get.snackbar(
          'تم التسجيل',
          'تم التسجيل بنجاح. قم بتأكيد OTP.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(() => OTPVerifyPage(email: email));
      } else {
        Get.snackbar(
          'فشل التسجيل',
          'تحقق من البيانات أو حاول لاحقاً.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ غير متوقع',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Register error: $e');
    } finally {
      isLoading.value = false;
      _hideLoadingDialog();
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    try {
      isLoading.value = true;
      _showLoadingDialog();

      final verified = await _authService.verifyOtp(email: email, otp: otp);

      if (verified) {
        Get.snackbar(
          'تم التفعيل',
          'تم تفعيل الحساب بنجاح',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // ✅ إصلاح تخزين البريد الإلكتروني
        userEmail.value = email;
        await _saveUserEmail(email);

        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar(
          'فشل التفعيل',
          'OTP غير صحيح أو منتهي',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ غير متوقع',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('OTP verify error: $e');
    } finally {
      isLoading.value = false;
      _hideLoadingDialog();
    }
  }

  Future<void> resendOtp(String email) async {
    try {
      isResending.value = true;

      final success = await _authService.resendOtp(email: email);

      if (success) {
        Get.snackbar(
          'تم الإرسال',
          'تم إعادة إرسال رمز OTP بنجاح',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          'فشل الإرسال',
          'فشل في إعادة إرسال رمز OTP، حاول مرة أخرى',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ في الاتصال',
        'تحقق من اتصال الإنترنت وحاول مرة أخرى',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Resend OTP error: $e');
    } finally {
      isResending.value = false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      isLoading.value = true;

      final response = await _authService.loginUser(
        email: email,
        password: password,
      );

      if (response != null) {
        final user = response['user'];
        final token = response['token'];
        final refreshToken = response['refreshToken'];

        currentUser.value = user;
        isLoggedIn.value = true;

        // ✅ حفظ البريد الإلكتروني
        userEmail.value = email;
        await _saveUserEmail(email);

        await _saveTokens(token, refreshToken);

        Get.snackbar(
          'تم تسجيل الدخول',
          'مرحباً ${user['email'] ?? user['username'] ?? 'بك'}',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(Routes.HOME);
        return true;
      } else {
        Get.snackbar(
          'فشل تسجيل الدخول',
          'تحقق من البريد الإلكتروني أو كلمة المرور',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'خطأ في الاتصال',
        'تحقق من اتصال الإنترنت وحاول مرة أخرى',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Login error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ تحديث دالة logout لتستخدم البريد المحفوظ والتعامل مع رد السيرفر
  Future<void> logout([String? email]) async {
    try {
      isLoading.value = true;
      _showLoadingDialog();

      // استخدام البريد المرسل أو البريد المحفوظ
      String emailToUse = email ?? userEmail.value;

      // إذا لم نجد البريد، نحاول الحصول عليه من بيانات المستخدم
      if (emailToUse.isEmpty && currentUser.value != null) {
        emailToUse = currentUser.value!['email'] ?? '';
      }

      // إذا لم نجد البريد، نحاول الحصول عليه من SharedPreferences
      if (emailToUse.isEmpty) {
        emailToUse = await getSavedUserEmail() ?? '';
      }


      Map<String, dynamic>? logoutResponse;
      bool logoutSuccess = false;

      if (emailToUse.isNotEmpty) {
        try {
          logoutResponse = await _authService.logoutUser(emailToUse);
          logoutSuccess =
              logoutResponse != null && logoutResponse['message'] != null;
        } catch (e) {
          logoutSuccess = false;
        }
      } else {
        print('No email found, performing local logout only');
        logoutSuccess = true; // نعتبر العملية ناجحة محلياً
      }

      // ✅ في جميع الأحوال، نقوم بمسح البيانات المحلية وتسجيل الخروج
      await _clearUserData();

      if (logoutSuccess) {
        String message = 'تم تسجيل الخروج بنجاح';

        if (logoutResponse != null && logoutResponse['message'] != null) {
          message = logoutResponse['message'];
        }

        Get.snackbar(
          'تم تسجيل الخروج',
          message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // حتى لو فشل الاتصال بالسيرفر، نعتبر العملية ناجحة محلياً
        Get.snackbar(
          'تم تسجيل الخروج',
          'تم تسجيل الخروج محلياً (فشل الاتصال بالخادم)',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }

      // ✅ الانتقال إلى صفحة تسجيل الدخول في جميع الحالات
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print('Logout error: $e');

      // ✅ حتى في حالة الخطأ، نقوم بمسح البيانات المحلية
      await _clearUserData();

      Get.snackbar(
        'تم تسجيل الخروج',
        'تم تسجيل الخروج محلياً (حدث خطأ في الاتصال)',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );

      Get.offAllNamed(Routes.LOGIN);
    } finally {
      // ✅ التأكد من إخفاء التحميل في جميع الحالات
      isLoading.value = false;
      _hideLoadingDialog();
      _ensureDialogsClosed(); // التأكد من إغلاق أي dialog مفتوح
    }
  }

  Future<void> _clearUserData() async {
    currentUser.value = null;
    isLoggedIn.value = false;
    userEmail.value = '';
    await _clearTokens();
    await _clearUserEmail();
  }

  // ✅ دالة إضافية لضمان إخفاء أي dialog مفتوح
  void _ensureDialogsClosed() {
    try {
      while (Get.isDialogOpen!) {
        Get.back();
      }
    } catch (e) {
      print('Error closing dialogs: $e');
    }
  }

  Future<void> forceLogout() async {
    try {
      // ✅ إخفاء أي loading dialog مفتوح
      isLoading.value = false;
      _hideLoadingDialog();
      _ensureDialogsClosed();

      await _clearUserData();
      Get.snackbar(
        'تم تسجيل الخروج',
        'تم تسجيل الخروج بنجاح',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print('Force logout error: $e');
    }
  }

  Future<void> loginWithPhone({
    required String phone,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      _showLoadingDialog();
      await Future.delayed(const Duration(seconds: 1));
      Get.snackbar(
        'غير متوفر حالياً',
        'تسجيل الدخول بالهاتف غير متوفر في الوقت الحالي\nيرجى استخدام البريد الإلكتروني',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ غير متوقع',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Login with phone error: $e');
    } finally {
      isLoading.value = false;
      _hideLoadingDialog();
    }
  }

  bool get isUserLoggedIn => isLoggedIn.value;
  Map<String, dynamic>? get getUserData => currentUser.value;
  String get getCurrentUserEmail => userEmail.value;

  // ✅ حفظ التوكنات
  Future<void> _saveTokens(String token, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
    await prefs.setString('refresh_token', refreshToken);
  }

  // ✅ مسح التوكنات
  Future<void> _clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  // ✅ الحصول على التوكن المحفوظ
  Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // ✅ حفظ البريد الإلكتروني
  Future<void> _saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
  }

  // ✅ الحصول على البريد الإلكتروني المحفوظ
  Future<String?> getSavedUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  // ✅ مسح البريد الإلكتروني
  Future<void> _clearUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
  }

  // ✅ التحقق من حالة الدخول عند بدء التطبيق
  Future<bool> checkLoginStatus() async {
    final token = await getSavedToken();
    final email = await getSavedUserEmail();

    if (token != null && email != null) {
      userEmail.value = email;
      isLoggedIn.value = true;
      return true;
    }
    return false;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
