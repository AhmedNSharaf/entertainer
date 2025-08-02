import 'package:enter_tainer/app/views/modules/provider_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/utils/utils.dart';
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

  final RxString userEmail = ''.obs;
  final RxString userName = ''.obs;
  // لتخزين نوع المستخدم
  final RxString userRole = ''.obs;

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
  required String role, // ← إضافة النوع
}) async {
  try {
    isLoading.value = true;
    _showLoadingDialog();

    final response = await _authService.registerUser(
      username: username,
      email: email,
      password: password,
      role: role, // ← تمريره للخدمة
    );

    if (response is bool && response == true) {
      userEmail.value = email;
      userName.value = username;
      userRole.value = role;

      await _saveUserData(email, username,userRole.value);

      Get.snackbar(
        'تم التسجيل',
        'تم التسجيل بنجاح. قم بتأكيد OTP.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.to(() => OTPVerifyPage(email: email, username: username));
    } else if (response is Map && response['error'] == 'conflict_error') {
      _hideLoadingDialog();
      Get.snackbar(
        'البريد مستخدم',
        response['message'] ?? 'هذا البريد الإلكتروني مستخدم بالفعل',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
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

  Future<void> verifyOtp(String email, String username, String otp) async {
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
        // ✅ حفظ البريد الإلكتروني واليوزر نيم المدخل
        userEmail.value = email;
        userName.value = username; // استخدام اليوزر نيم المدخل

        await _saveUserData(email, username,userRole.value); // ✅ تمرير اليوزر نيم

        if (userRole.toLowerCase() == 'customer') {
          Get.offAllNamed(Routes.HOME);
        } else if (userRole.toLowerCase() == 'provider') {
          Get.offAll(ProviderScreen()); // تأكد من وجود هذا الـ route
        } else {
          // في حالة نوع مستخدم غير معروف، انتقل للصفحة الافتراضية
          Get.offAllNamed(Routes.HOME);
        }
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

  String _extractUsernameFromEmail(String email) {
    return email.split('@').first;
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
        userEmail.value = email;
        

        // ✅ الحصول على نوع المستخدم من الـ response
        String userType = '';
        if (user != null &&
            user['group'] != null &&
            user['group']['name'] != null) {
          userType = user['group']['name'];
        }

        // ✅ محاولة الحصول على اليوزر نيم من رد السيرفر أولاً
        String usernameFromResponse = '';
        if (user != null && user['username'] != null) {
          usernameFromResponse = user['username'];
        }

        // إذا لم نحصل على اليوزر نيم من السيرفر، نستخدم المحفوظ مسبقاً
        if (usernameFromResponse.isNotEmpty) {
          userName.value = usernameFromResponse;
          await _saveUserData(email, usernameFromResponse,userType);
        } else {
          // إذا لم نجد اليوزر نيم، نحاول الحصول عليه من المحفوظ مسبقاً
          String? savedUsername = await getSavedUserName();
          if (savedUsername != null && savedUsername.isNotEmpty) {
            userName.value = savedUsername;
          } else {
            // كحل أخير، نقوم باستخراجه من الإيميل
            userName.value = _extractUsernameFromEmail(email);
            await _saveUserData(email, userName.value,userType);
          }
        }

        await _saveTokens(token, refreshToken);

        // ✅ حفظ نوع المستخدم
        // await _saveUserType(userType);

        Get.snackbar(
          'تم تسجيل الدخول',
          'مرحباً ${userName.value}',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // ✅ الانتقال بناءً على نوع المستخدم
        if (userType.toLowerCase() == 'customer') {
          Get.offAllNamed(Routes.HOME);
        } else if (userType.toLowerCase() == 'provider') {
          Get.offAll(ProviderScreen()); // تأكد من وجود هذا الـ route
        } else {
          // في حالة نوع مستخدم غير معروف، انتقل للصفحة الافتراضية
          Get.offAllNamed(Routes.HOME);
        }

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

  Future<void> logout([String? email]) async {
    try {
      isLoading.value = true;
      _showLoadingDialog();

      String emailToUse = email ?? userEmail.value;

      if (emailToUse.isEmpty && currentUser.value != null) {
        emailToUse = currentUser.value!['email'] ?? '';
      }

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
        logoutSuccess = true;
      }

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
        Get.snackbar(
          'تم تسجيل الخروج',
          'تم تسجيل الخروج محلياً (فشل الاتصال بالخادم)',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }

      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print('Logout error: $e');

      await _clearUserData();

      Get.snackbar(
        'تم تسجيل الخروج',
        'تم تسجيل الخروج محلياً (حدث خطأ في الاتصال)',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );

      Get.offAllNamed(Routes.LOGIN);
    } finally {
      isLoading.value = false;
      _hideLoadingDialog();
      _ensureDialogsClosed();
    }
  }

  Future<void> _clearUserData() async {
    currentUser.value = null;
    isLoggedIn.value = false;
    userEmail.value = '';
    userName.value = ''; // ✅ مسح اليوزر نيم أيضاً
    await _clearTokens();
    await _clearUserEmail();
    await _clearUserName(); // ✅ مسح اليوزر نيم من التخزين
  }

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
  String get getCurrentUserName => userName.value; // ✅ إضافة getter لليوزر نيم

  Future<void> _saveTokens(String token, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future<void> _clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // ✅ تحديث دالة حفظ البريد والاسم
  Future<void> _saveUserData(String email, String username,String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    await prefs.setString('user_name', username); // ✅ حفظ اليوزر نيم
    await prefs.setString('user_type', userType); 
  }

  Future<String?> getSavedUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  // ✅ دالة جديدة للحصول على اليوزر نيم المحفوظ
  Future<String?> getSavedUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name');
  }
  Future<String?> getSavedUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('type');
  }

  Future<void> _clearUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
  }

  // ✅ دالة جديدة لمسح اليوزر نيم
  Future<void> _clearUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
  }

  // ✅ تحديث دالة التحقق من حالة الدخول
  Future<bool> checkLoginStatus() async {
    final token = await getSavedToken();
    final email = await getSavedUserEmail();
    final username =
        await getSavedUserName(); // ✅ الحصول على اليوزر نيم المحفوظ

    if (token != null && email != null) {
      userEmail.value = email;
      // ✅ إذا وجد اليوزر نيم محفوظ، استخدمه، وإلا استخرجه من الإيميل
      if (username != null && username.isNotEmpty) {
        userName.value = username;
      } else {
        userName.value = _extractUsernameFromEmail(email);
        // حفظ اليوزر نيم المستخرج للمرة القادمة
        await _saveUserData(email, userName.value,userRole.value);
      }
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
