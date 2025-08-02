// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:enter_tainer/app/views/modules/auth/widgets/build_check_box_tile.dart';
import 'package:enter_tainer/app/views/modules/auth/widgets/tab_item_selector.dart';
import 'package:enter_tainer/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/image_utils/src/super_imageview.dart';
import 'package:neuss_utils/utils/constants.dart';
import 'package:neuss_utils/widgets/src/super_scaffold.dart';
import 'package:neuss_utils/widgets/src/super_phone_field.dart';
import 'package:neuss_utils/widgets/src/txt.dart';

import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/auth_controller.dart';

enum RegisterWith { phone, email }

enum UserType { user, provider }

class RegisterPage extends GetView<AppController> {
  RegisterPage({super.key});

  final AuthController authController = Get.put(AuthController());

  final _phoneNum = ''.obs;
  final _email = ''.obs;
  final _username = ''.obs; // إضافة اليوزر نيم

  String get phoneNum => _phoneNum.value;
  set phoneNum(String val) => _phoneNum.value = val;

  String get email => _email.value;
  set email(String val) => _email.value = val;

  String get username => _username.value; // إضافة getter و setter
  set username(String val) => _username.value = val;

  final _gender = true.obs;
  bool get gender => _gender.value;
  set gender(bool val) => _gender.value = val;

  final _userType = UserType.user.obs;
  UserType get userType => _userType.value;
  set userType(UserType val) => _userType.value = val;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController =
      TextEditingController(); // إضافة controller لليوزر نيم
  final TextEditingController passController = TextEditingController();
  final TextEditingController pass2Controller = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  final _registerWith = RegisterWith.phone.obs;
  final _isPhoneFieldReady = false.obs;
  final _isPasswordVisible = false.obs;
  final _isConfirmPasswordVisible = false.obs;
  final _isLoading = false.obs;

  SuperPhoneField? _phoneFieldWidget;

  SuperPhoneField get phoneFieldWidget {
    _phoneFieldWidget ??= SuperPhoneField(
      controller: phoneController,
      fillColor: Colors.white,
      initialDialCode: '+962',
      initialPhone: controller.phoneNum,
      enableDebug: false,
      onPhoneChanged: (phone) {},
      onCountryChanged: (countryCode) {},
      onFullPhoneChanged: (completeNum) {
        if (completeNum != null) {
          phoneNum = completeNum;
          controller.phoneNum = phoneNum;
        }
      },
    );
    return _phoneFieldWidget!;
  }

  @override
  Widget build(BuildContext context) {
    final selectedType = Get.parameters['type'];
    if (selectedType == 'provider') {
      userType = UserType.provider;
    } else {
      userType = UserType.user;
    }

    phoneNum = controller.phoneNum;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isPhoneFieldReady.value) {
        _preloadPhoneField();
      }
    });

    return SuperScaffold(
      backBtnBgColor: Colors.transparent,
      showBackBtn: true,
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  vSpace32,
                  _buildUserTypeIndicator(),
                  vSpace24,
                  _buildTabSelector(),
                  vSpace24,
                  _buildInputSection(),
                  vSpace32,
                  _buildFooterSection(),
                  vSpace24,
                ],
              ),
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
            'إنشاء حساب جديد',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          vSpace8,
          const Txt(
            'أنشئ حسابك للبدء في استخدام التطبيق',
            fontSize: 16,
            color: Colors.grey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUserTypeIndicator() {
    return Obx(() {
      final isSupplier = userType == UserType.provider;
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                isSupplier
                    ? Colors.orange.withOpacity(0.1)
                    : AppColors.appMainColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSupplier ? Colors.orange : AppColors.appMainColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSupplier ? Icons.work : Icons.person,
                color: isSupplier ? Colors.orange : AppColors.appMainColor,
                size: 24,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(
                      isSupplier ? 'تسجيل كمقدم خدمة' : 'تسجيل كعميل',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    vSpace4,
                    Txt(
                      isSupplier
                          ? 'ستتمكن من تقديم خدماتك للعملاء'
                          : 'ستتمكن من طلب الخدمات من مقدمي الخدمة',
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
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
                isSelected: _registerWith.value == RegisterWith.phone,
                icon: Icons.phone,
                label: 'رقم الهاتف',
                onTap: () {
                  _registerWith.value = RegisterWith.phone;
                  emailController.clear();
                  email = '';
                },
              ),
              TabItemSelector(
                isSelected: _registerWith.value == RegisterWith.email,
                icon: Icons.email,
                label: 'البريد الإلكتروني',
                onTap: () {
                  _registerWith.value = RegisterWith.email;
                  phoneController.clear();
                  phoneNum = '';
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildInputSection() {
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 60),
          child: _buildInputField(),
        ),
        vSpace16,
        // إضافة خانة اليوزر نيم
        _buildUsernameField(),
        vSpace16,
        Directionality(
          textDirection: TextDirection.rtl,
          child: _buildPasswordField(
            controller: passController,
            hint: 'كلمة المرور',
            isVisible: _isPasswordVisible,
            icon: Icons.lock_outline,
            validators: [
              FormBuilderValidators.required(errorText: 'كلمة المرور مطلوبة'),
              FormBuilderValidators.minLength(6, errorText: '6 أحرف على الأقل'),
            ],
          ),
        ),
        vSpace16,
        Directionality(
          textDirection: TextDirection.rtl,
          child: _buildPasswordField(
            controller: pass2Controller,
            hint: 'تأكيد كلمة المرور',
            isVisible: _isConfirmPasswordVisible,
            icon: Icons.lock_outline,
            validators: [
              FormBuilderValidators.required(errorText: 'مطلوب'),
              (value) {
                if (value != passController.text) {
                  return 'كلمة المرور غير متطابقة';
                }
                return null;
              },
            ],
          ),
        ),
        vSpace16,
        Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Spacer(),
                BuildCheckBoxTile(
                  title: 'حفظ بيانات تسجيل الدخول',
                  value: controller.saveUserPermanently,
                  onChanged:
                      (val) => controller.saveUserPermanently = val ?? false,
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // إضافة widget لخانة اليوزر نيم
  Widget _buildUsernameField() {
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
          controller: usernameController,
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(
            hintText: 'اسم المستخدم',
            hintStyle: TextStyle(fontFamily: AppFonts.cairoFontFamily),
            prefixIcon: Icon(
              Icons.person_outline,
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
              return 'اسم المستخدم مطلوب';
            }
            if (value.length < 3) {
              return 'اسم المستخدم يجب ألا يقل عن 3 أحرف';
            }
            if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
              return 'اسم المستخدم يجب أن يحتوي على أحرف وأرقام فقط';
            }
            return null;
          },
          onChanged: (value) {
            if (value != null) username = value;
          },
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required RxBool isVisible,
    required IconData icon,
    required List<String? Function(String?)> validators,
  }) {
    return Obx(() {
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
        child: TextFormField(
          controller: controller,
          obscureText: !isVisible.value,
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontFamily: AppFonts.cairoFontFamily),
            prefixIcon: Icon(icon, color: AppColors.appMainColor),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible.value ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[600],
              ),
              onPressed: () => isVisible.toggle(),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          validator: (value) {
            for (final validator in validators) {
              final result = validator(value);
              if (result != null) return result;
            }
            return null;
          },
        ),
      );
    });
  }

  Widget _buildFooterSection() {
    return Column(
      children: [
        Obx(() {
          return InkWell(
            onTap: _isLoading.value ? null : submitSignUp,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color:
                    _isLoading.value
                        ? Colors.grey[400]
                        : AppColors.appMainColor,
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                            strokeWidth: 2,
                          ),
                        )
                        : Text(
                          userType == UserType.provider
                              ? 'تسجيل كمقدم خدمة'
                              : 'إنشاء حساب',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.cairoFontFamily,
                          ),
                        ),
              ),
            ),
          );
        }),
        vSpace16,
        Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Txt(
                'لديك حساب بالفعل؟ ',
                fontSize: 14,
                color: Colors.grey,
                fontFamily: AppFonts.cairoFontFamily,
              ),
              TextButton(
                onPressed: submitLogin,
                child: Txt(
                  'تسجيل الدخول',
                  fontSize: 16,
                  color: AppColors.appMainColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.cairoFontFamily,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputField() {
    return Obx(() {
      if (_registerWith.value == RegisterWith.phone) {
        return Obx(() {
          if (!_isPhoneFieldReady.value) return _buildLoadingPlaceholder();
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Container(
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
              child: phoneFieldWidget,
            ),
          );
        });
      } else {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Container(
            key: const ValueKey('email'),
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
                decoration: InputDecoration(
                  hintText: 'البريد الإلكتروني',
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
                  if (value == null || value.isEmpty)
                    return 'البريد الإلكتروني مطلوب';
                  if (!GetUtils.isEmail(value))
                    return 'البريد الإلكتروني غير صحيح';
                  return null;
                },
                onChanged: (value) {
                  if (value != null) email = value;
                },
              ),
            ),
          ),
        );
      }
    });
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _preloadPhoneField() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_isPhoneFieldReady.value) {
        phoneFieldWidget;
        Future.delayed(const Duration(milliseconds: 500), () {
          _isPhoneFieldReady.value = true;
        });
      }
    });
  }

  // تحديث دالة submitSignUp لاستخدام اليوزر نيم المدخل
  void submitSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      _isLoading.value = true;

      // استخدام اسم المستخدم المدخل مباشرة بدلاً من قصه من الإيميل
      final userEmail =
          _registerWith.value == RegisterWith.email
              ? email
              : '${phoneNum.replaceAll('+', '')}@example.com';

      try {
        final selectedType = Get.parameters['type'];
        if (selectedType == 'provider') {
          userType = UserType.provider;
        } else {
          userType = UserType.user;
        }
        await authController.registerUser(
          username: username, // استخدام اليوزر نيم المدخل مباشرة
          email: userEmail,
          password: passController.text,
          role: "provider",
        );

        _isLoading.value = false;
      } catch (e) {
        _isLoading.value = false;
        Get.snackbar(
          'خطأ',
          'حدث خطأ أثناء التسجيل: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  void submitLogin() {
    Get.offNamed(Routes.LOGIN);
  }
}
