// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:enter_tainer/app/views/modules/auth/widgets/tab_item_selector.dart';
import 'package:enter_tainer/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/widgets/src/super_scaffold.dart';
import 'package:neuss_utils/widgets/src/txt.dart';
import 'package:neuss_utils/widgets/src/super_phone_field.dart';
import 'package:neuss_utils/image_utils/src/super_imageview.dart';
import 'package:neuss_utils/utils/constants.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../controllers/app_controller.dart';

enum LoginWith { phone, email }

class ForgetPassPage extends GetView<AppController> {
  ForgetPassPage({super.key, this.onSubmit});

  final void Function(String identifier)? onSubmit;

  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _isLoading = false.obs;
  final _phoneNum = ''.obs;
  final _isPhoneValid = false.obs;
  final _selectedTab = LoginWith.email.obs; // افتراضياً البريد الإلكتروني

  String get phoneNum => _phoneNum.value;
  set phoneNum(String val) => _phoneNum.value = val;

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      showBackBtn: true,
      backBtnBgColor: Colors.transparent,
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                vSpace32,
                _buildTabSelector(),
                vSpace24,
                _buildInputField(),
                vSpace32,
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: 0.8 + (0.2 * value),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.appMainColor.withOpacity(0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.appMainColor.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SuperImageView(
                imgAssetPath: AppAssets.entertainerIcon3,
                height: 80,
                width: 80,
                fit: BoxFit.contain,
              ),
            ),
          ),
          vSpace16,
          const Txt(
            'نسيت كلمة المرور؟',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          vSpace8,
          const Txt(
            'اختر الطريقة المناسبة لاستعادة كلمة المرور',
            fontSize: 16,
            color: Colors.grey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              TabItemSelector(
                isSelected: _selectedTab.value == LoginWith.email,
                icon: Icons.email_outlined,
                label: 'البريد الإلكتروني',
                onTap: () {
                  _selectedTab.value = LoginWith.email;
                  // مسح البيانات عند التبديل
                  phoneController.clear();
                  phoneNum = '';
                  _isPhoneValid.value = false;
                },
              ),
              const SizedBox(width: 4),
              TabItemSelector(
                isSelected: _selectedTab.value == LoginWith.phone,
                icon: Icons.phone_outlined,
                label: 'رقم الهاتف',
                onTap: () {
                  _selectedTab.value = LoginWith.phone;
                  // مسح البيانات عند التبديل
                  emailController.clear();
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildInputField() {
    return Obx(() {
      if (_selectedTab.value == LoginWith.phone) {
        return _buildPhoneField();
      } else {
        return _buildEmailField();
      }
    });
  }

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textDirection: TextDirection.ltr,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: 'البريد الإلكتروني',
            hintStyle: TextStyle(color: Colors.grey[500]),
            prefixIcon: Icon(
              Icons.email_outlined,
              color: AppColors.appMainColor,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'البريد الإلكتروني مطلوب';
            }
            if (!GetUtils.isEmail(value)) {
              return 'يرجى إدخال بريد إلكتروني صحيح';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SuperPhoneField(
        controller: phoneController,
        enableDebug: false,
        useSimIfAvailable: true,
        initialDialCode: '+962',
        onPhoneChanged: (phone) {
          if (phone != null && phone.isNotEmpty) {
            _isPhoneValid.value = phone.length >= 7;
          } else {
            _isPhoneValid.value = false;
          }
        },
        onCountryChanged: (countryCode) {
          debugPrint('Country changed to: $countryCode');
        },
        onFullPhoneChanged: (completeNum) {
          try {
            if (completeNum != null && completeNum.isNotEmpty) {
              phoneNum = completeNum;
              _isPhoneValid.value = completeNum.length >= 10;
            } else {
              phoneNum = '';
              _isPhoneValid.value = false;
            }
          } catch (e) {
            debugPrint('Error in onFullPhoneChanged: $e');
            phoneNum = '';
            _isPhoneValid.value = false;
          }
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Obx(() {
      String buttonText =
          _selectedTab.value == LoginWith.phone
              ? 'إرسال رابط الاستعادة عبر الرسائل'
              : 'إرسال رابط الاستعادة';

      return InkWell(
        onTap: _isLoading.value ? null : _submitReset,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: _isLoading.value ? Colors.grey[400] : AppColors.appMainColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.appMainColor.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child:
                _isLoading.value
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                    : Txt(
                      buttonText,
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
          ),
        ),
      );
    });
  }

  void _submitReset() {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        _isLoading.value = true;

        String identifier = '';
        String successMessage = '';

        if (_selectedTab.value == LoginWith.phone) {
          if (phoneNum.isEmpty || !_isPhoneValid.value) {
            _isLoading.value = false;
            _showErrorSnackbar('يرجى إدخال رقم هاتف صحيح');
            return;
          }

          if (!RegExp(r'^\+[1-9]\d{1,14}$').hasMatch(phoneNum)) {
            _isLoading.value = false;
            _showErrorSnackbar('تنسيق رقم الهاتف غير صحيح');
            return;
          }

          identifier = phoneNum;
          successMessage =
              'تم إرسال رابط الاستعادة عبر الرسائل النصية إلى $identifier';
        } else {
          String email = emailController.text.trim();
          if (email.isEmpty || !GetUtils.isEmail(email)) {
            _isLoading.value = false;
            _showErrorSnackbar('يرجى إدخال بريد إلكتروني صحيح');
            return;
          }
          identifier = email;
          successMessage = 'تم إرسال رابط الاستعادة إلى $identifier';
        }

        // محاكاة استدعاء API
        Future.delayed(const Duration(seconds: 2), () {
          _isLoading.value = false;

          if (onSubmit != null) {
            try {
              onSubmit!(identifier);
              Get.back();
            } catch (e) {
              debugPrint('Error in onSubmit callback: $e');
              _showErrorSnackbar('حدث خطأ أثناء الإرسال');
            }
          } else {
            _showSuccessSnackbar(successMessage);
            Get.back();
          }
        });
      }
    } catch (e) {
      _isLoading.value = false;
      debugPrint('Error in _submitReset: $e');
      _showErrorSnackbar('حدث خطأ غير متوقع');
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'خطأ',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'تم الإرسال',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
