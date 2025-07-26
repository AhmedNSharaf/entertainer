// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:enter_tainer/app/views/modules/auth/forgetpass_view.dart';
import 'package:enter_tainer/app/views/modules/auth/widgets/build_check_box_tile.dart';
import 'package:enter_tainer/app/views/modules/auth/widgets/tab_item_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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

enum LoginWith { phone, email }

class LoginPage extends GetView<AppController> {
  LoginPage({super.key});

  final _phoneNum = ''.obs;
  final _email = ''.obs;

  String get phoneNum => _phoneNum.value;
  set phoneNum(String val) => _phoneNum.value = val;

  String get email => _email.value;
  set email(String val) => _email.value = val;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  final _loginWith = LoginWith.phone.obs;
  final _isPhoneFieldReady = false.obs;
  final _isPasswordVisible = false.obs;
  final _isLoading = false.obs;

  // Pre-initialize the SuperPhoneField widget
  SuperPhoneField? _phoneFieldWidget;

  SuperPhoneField get phoneFieldWidget {
    _phoneFieldWidget ??= SuperPhoneField(
      controller: phoneController,
      enableDebug: false,
      useSimIfAvailable: true,
      initialPhone: controller.phoneNum,
      initialDialCode: '+962',
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
    phoneNum = controller.phoneNum;

    // Start loading phone field immediately
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
                  // vSpace12,

                  // Header Section
                  _buildHeader(),

                  vSpace32,

                  // Login Method Selector
                  _buildTabSelector(),

                  vSpace24,

                  // Input Fields
                  _buildInputSection(),

                  vSpace32,

                  // Login Button and Footer
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
          // Logo with animation
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
                    spreadRadius: 0,
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

          // Title
          const Txt(
            'مرحباً بك',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),

          vSpace8,

          const Txt(
            'سجل دخولك للوصول إلى حسابك',
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
              spreadRadius: 0,
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
                isSelected: _loginWith.value == LoginWith.phone,
                icon: Icons.phone,
                label: 'رقم الهاتف',
                onTap: () {
                  _loginWith.value = LoginWith.phone;
                  emailController.clear();
                  email = '';
                },
              ),
              TabItemSelector(
                isSelected: _loginWith.value == LoginWith.email,
                icon: Icons.email,
                label: 'البريد الإلكتروني',
                onTap: () {
                  _loginWith.value = LoginWith.email;
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

  // Widget _buildTabItem({
  //   required LoginWith type,
  //   required IconData icon,
  //   required String label,
  // }) {
  //   return Expanded(
  //     child: GestureDetector(
  //       onTap: () {
  //         _loginWith.value = type;
  //         if (type == LoginWith.phone) {
  //           emailController.clear();
  //           email = '';
  //         } else {
  //           phoneController.clear();
  //           phoneNum = '';
  //         }
  //       },
  //       child: AnimatedContainer(
  //         duration: const Duration(milliseconds: 300),
  //         padding: const EdgeInsets.symmetric(vertical: 14),
  //         decoration: BoxDecoration(
  //           color:
  //               _loginWith.value == type
  //                   ? AppColors.appMainColor
  //                   : Colors.transparent,
  //           borderRadius: BorderRadius.circular(8),
  //           boxShadow:
  //               _loginWith.value == type
  //                   ? [
  //                     BoxShadow(
  //                       color: AppColors.appMainColor.withOpacity(0.3),
  //                       spreadRadius: 0,
  //                       blurRadius: 8,
  //                       offset: const Offset(0, 2),
  //                     ),
  //                   ]
  //                   : null,
  //         ),
  //         child: Center(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [

  //               Flexible(
  //                 child: Txt(
  //                   label,
  //                   color:
  //                       _loginWith.value == type
  //                           ? Colors.white
  //                           : Colors.grey[600]!,
  //                   fontSize: 14,
  //                   fontWeight:
  //                       _loginWith.value == type
  //                           ? FontWeight.w600
  //                           : FontWeight.normal,
  //                 ),
  //               ),
  //               hSpace8,
  //               Icon(
  //                 icon,
  //                 color:
  //                     _loginWith.value == type
  //                         ? Colors.white
  //                         : Colors.grey[600],
  //                 size: 18,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildInputSection() {
    return Column(
      children: [
        // Phone/Email Input
        Container(
          constraints: const BoxConstraints(minHeight: 60),
          child: _buildInputField(),
        ),

        vSpace16,

        // Password Field
        _buildPasswordField(),

        vSpace16,

        // Options Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  // تمرير نوع تسجيل الدخول الحالي
                  Get.to(
                    () => ForgetPassPage(
                      onSubmit: (identifier) {
                        // يمكنك إضافة معالجة إضافية هنا إذا لزم الأمر
                        print('Reset password for: $identifier');
                      },
                    ),
                  );
                },
                child: Txt(
                  'نسيت كلمة المرور؟',
                  fontSize: 14,
                  color: AppColors.appMainColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Expanded(
              child: Obx(() {
                return BuildCheckBoxTile(
                  title: 'حفظ بيانات الدخول',
                  value: controller.saveUserPermanently,
                  onChanged:
                      (value) =>
                          controller.saveUserPermanently = value ?? false,
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            controller: passController,
            obscureText: !_isPasswordVisible.value,
            textDirection: TextDirection.ltr,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: 'كلمة المرور',
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: AppColors.appMainColor,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey[600],
                ),
                onPressed: () => _isPasswordVisible.toggle(),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'كلمة المرور مطلوبة';
              }
              if (value.length < 3) {
                return 'يجب أن تكون كلمة المرور 3 أحرف على الأقل';
              }
              return null;
            },
          ),
        ),
      );
    });
  }

  Widget _buildFooterSection() {
    return Column(
      children: [
        // Login Button
        Obx(() {
          return InkWell(
            onTap: _isLoading.value ? null : submitLogin,
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
                    spreadRadius: 0,
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
                        : const Txt(
                          'تسجيل الدخول',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
              ),
            ),
          );
        }),

        vSpace16,

        // Sign Up Link
        Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Txt('ليس لديك حساب؟ ', fontSize: 14, color: Colors.grey),
              TextButton(
                onPressed: submitSignUp,
                child: Txt(
                  'إنشاء حساب جديد',
                  fontSize: 16,
                  color: AppColors.appMainColor,
                  fontWeight: FontWeight.bold,
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
      if (_loginWith.value == LoginWith.phone) {
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
                    spreadRadius: 0,
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
                  spreadRadius: 0,
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
                    return 'البريد الإلكتروني غير صحيح';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value != null) {
                    email = value;
                  }
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
            spreadRadius: 0,
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
          // hSpace12,
          Expanded(
            child: Container(
              height: 20,
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

  void submitSignUp() {
    Get.toNamed(Routes.SELECT_USER_TYPE);
  }

  void submitLogin() {
    Get.toNamed(Routes.HOME);
    // if (_formKey.currentState?.validate() ?? false) {
    //   _isLoading.value = true;

    //   String password = passController.text.trim();
    //   bool isValidInput = false;
    //   String identifier = '';

    //   if (_loginWith.value == LoginWith.phone) {
    //     isValidInput = !phoneNum.isNullOrEmptyOrWhiteSpace;
    //     identifier = phoneNum.correctPhoneDir;
    //   } else {
    //     isValidInput = !email.isNullOrEmptyOrWhiteSpace;
    //     identifier = email;
    //   }

    //   if (isValidInput) {
    //     String verificationMessage =
    //         _loginWith.value == LoginWith.phone
    //             ? '${'verify phone'.tr} $identifier ${'?'.tr}'
    //             : '${'verify email'.tr} $identifier ${'?'.tr}';

    //     showConfirmationDialog(
    //       msg: verificationMessage,
    //       function: () {
    //         // Create user model based on login method
    //         UserModel user = UserModel(
    //           phone: _loginWith.value == LoginWith.phone ? phoneNum : null,
    //           email: _loginWith.value == LoginWith.email ? email : null,
    //           password: password,
    //         );

    //         controller.verifyUserPhone(user, AuthStates.login);
    //       },
    //     );
    //   }

    //   // Reset loading state after a delay
    //   Future.delayed(const Duration(milliseconds: 1500), () {
    //     _isLoading.value = false;
    //   });
    // }
  }

  void submitForgotPassword() {
    Get.toNamed(Routes.FORGETPASS);
  }
}
