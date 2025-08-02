import 'dart:async';
import 'package:enter_tainer/core/routes/app_pages.dart';
import 'package:enter_tainer/core/services/verify_otp.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/utils/constants.dart';
import 'package:neuss_utils/utils/helpers.dart';
import 'package:neuss_utils/widgets/src/super_scaffold.dart';
import 'package:neuss_utils/widgets/src/txt.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/auth_controller.dart';

// ignore: must_be_immutable
class OTPVerifyPage extends GetView<AppController> {
  OTPVerifyPage( {required this.email,required this.username, super.key});
  final String email;
  final String username;


  final AuthController authController = Get.find<AuthController>();
  final TextEditingController codeController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  final _isLoading = false.obs;
  
  // متغيرات للتحكم في العد التنازلي
  final RxInt resendCooldown = 0.obs;
  final RxBool canResend = true.obs;
  Timer? _resendTimer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SuperScaffold(
        showBackBtn: false,
        body: SizedBox(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: FormBuilder(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Txt(
                      _getVerificationTitle(),
                      fontWeight: FontWeight.bold,
                      color: AppColors.appMainColor,
                      fontSize: 22,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.3,
                    child: const FlareActor(
                      AppAssets.otp,
                      animation: "otp",
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.center,
                    ),
                  ),
                  vSpace16,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 8,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: _getVerificationMessage(),
                        children: [
                          TextSpan(
                            text: _getContactInfo(),
                            style: const TextStyle(
                              color: Colors.orange,
                              locale: Locale('en'),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                        style: const TextStyle(
                          color: AppColors.appMainColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  vSpace16,
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      backgroundColor: Colors.transparent,
                      useHapticFeedback: true,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 55,
                        fieldWidth: Get.width * 0.14,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.grey[100],
                        selectedFillColor: Colors.blue[50],
                        errorBorderColor: Colors.red,
                        selectedColor: AppColors.appMainColor,
                        inactiveColor: Colors.grey[300],
                        activeColor: AppColors.appMainColor,
                        borderWidth: 2,
                      ),
                      pastedTextStyle: const TextStyle(color: Colors.black),
                      animationDuration: const Duration(milliseconds: 300),
                      cursorColor: AppColors.appMainColor,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        height: 1.6,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                      controller: codeController,
                      onCompleted: (v) {
                        mPrint("OTP Completed: $v");
                        verifyPressed();
                      },
                      onChanged: (value) {
                        // يمكنك إضافة validation هنا إذا كنت تريد
                      },
                      beforeTextPaste: (text) {
                        mPrint("Allowing to paste $text");
                        // التحقق من أن النص المنسوخ أرقام فقط
                        return text?.contains(RegExp(r'^[0-9]+$')) ?? false;
                      },
                    ),
                  ),
                  vSpace24,
                  
                  // قسم إعادة الإرسال المحسن
                  _buildResendSection(),
                  
                  vSpace24,
                  
                  // زر التحقق
                  _buildVerifyButton(),
                  
                  vSpace16,
                  
                  // خيار تغيير البريد الإلكتروني
                  _buildChangeEmailSection(),
                  
                  vSpace48,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // قسم إعادة الإرسال المحسن
  Widget _buildResendSection() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: canResend.value ? Colors.green : Colors.orange,
                ),
                hSpace8,
                Txt(
                  canResend.value 
                      ? "يمكنك إعادة الإرسال الآن"
                      : "يمكنك إعادة الإرسال خلال ${resendCooldown.value} ثانية",
                  fontSize: 14,
                  color: canResend.value ? Colors.green[700] : Colors.orange[700],
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            vSpace12,
            GestureDetector(
              onTap: canResend.value ? _resendOtp : null,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: canResend.value ? AppColors.appMainColor : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: canResend.value
                      ? [
                          BoxShadow(
                            color: AppColors.appMainColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (authController.isResending.value)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    else
                      Icon(
                        Icons.refresh,
                        color: canResend.value ? Colors.white : Colors.grey[600],
                        size: 18,
                      ),
                    hSpace8,
                    Txt(
                      authController.isResending.value 
                          ? "جاري الإرسال..."
                          : "إعادة إرسال الرمز",
                      color: canResend.value ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // زر التحقق المحسن
  Widget _buildVerifyButton() {
    return Obx(() {
      return GestureDetector(
        onTap: _isLoading.value ? null : verifyPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: _isLoading.value ? Colors.grey[400] : AppColors.appMainColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isLoading.value
                ? null
                : [
                    BoxShadow(
                      color: AppColors.appMainColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading.value)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              else
                const Icon(
                  Icons.verified_user,
                  color: Colors.white,
                  size: 20,
                ),
              hSpace8,
              Txt(
                _isLoading.value ? 'جاري التحقق...' : 'تأكيد الرمز',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      );
    });
  }

  // قسم تغيير البريد الإلكتروني
  Widget _buildChangeEmailSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Txt(
            _getChangeContactText(),
            color: Colors.grey[600],
            fontSize: 14,
          ),
          hSpace8,
          GestureDetector(
            onTap: changeNumPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.appMainColor, width: 1),
                ),
              ),
              child: const Txt(
                'تغييره',
                color: AppColors.appMainColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  String _getVerificationTitle() {
    if (controller.isUsingEmail) {
      return 'تأكيد البريد الإلكتروني';
    } else {
      return 'تأكيد رقم الهاتف';
    }
  }

  String _getVerificationMessage() {
    if (controller.isUsingEmail) {
      return "أدخل الرمز المرسل إلى: ";
    } else {
      return "أدخل الرمز المرسل إلى: ";
    }
  }

  String _getContactInfo() {
    return email;
  }

  String _getChangeContactText() {
    if (controller.isUsingEmail) {
      return 'البريد الإلكتروني غير صحيح؟';
    } else {
      return 'رقم الهاتف غير صحيح؟';
    }
  }

  // التحقق من OTP
  Future<void> verifyPressed() async {
    if (codeController.text.trim().length != 6) {
      _showErrorSnackbar('يرجى إدخال رمز OTP كاملاً (6 أرقام)');
      return;
    }

    _isLoading.value = true;

    try {
      await authController.verifyOtp(email, username,codeController.text.trim());
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
      _showErrorSnackbar('حدث خطأ أثناء التحقق: $e');
    }
  }

  // إعادة إرسال OTP
  Future<void> _resendOtp() async {
    if (!canResend.value || authController.isResending.value) return;

    try {
      await authController.resendOtp(email);
      _startResendCooldown();
      codeController.clear();
    } catch (e) {
      _showErrorSnackbar('فشل في إعادة إرسال OTP: $e');
    }
  }

  // بدء العد التنازلي
  void _startResendCooldown() {
    canResend.value = false;
    resendCooldown.value = 60;
    
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCooldown.value > 0) {
        resendCooldown.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  // عرض رسالة خطأ
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'خطأ',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  void changeNumPressed() {
    // إلغاء العد التنازلي عند الرجوع
    _resendTimer?.cancel();
    Get.back();
  }

  @override
  void onClose() {
    // تنظيف الموارد
    _resendTimer?.cancel();
    codeController.dispose();
    // super.onClose();
  }
}