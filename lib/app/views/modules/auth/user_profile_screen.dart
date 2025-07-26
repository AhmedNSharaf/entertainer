import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/image_utils/src/super_imageview.dart';
import 'package:neuss_utils/utils/constants.dart';
import 'package:neuss_utils/utils/helpers.dart';
import 'package:neuss_utils/utils/my_extensions.dart';
import 'package:neuss_utils/widgets/src/app_button.dart';
import 'package:neuss_utils/widgets/src/super_scaffold.dart';
import 'package:neuss_utils/widgets/src/super_decorated_container.dart';
import 'package:neuss_utils/widgets/src/super_edit_text.dart';
import 'package:neuss_utils/widgets/src/super_phone_field.dart';
import 'package:neuss_utils/widgets/src/super_radio_group.dart';
import 'package:neuss_utils/widgets/src/txt.dart';
import 'package:ready_extensions/ready_extensions.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_helpers.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/user_info_controller.dart';
import '../../../models/user_model.dart';

class UserProfilePage extends GetView<AppController> {
  UserProfilePage({this.user, this.viewOnly = false, super.key});

  final UserModel? user;
  final bool viewOnly;

  late final UserInfoController userInfoController = UserInfoController(user);

  String getUserPhone() {
    String? s = userInfoController.user.phone ?? controller.phoneNum;
    if (!s.isNullOrEmptyOrWhiteSpace) {
      s = '+${s.replaceAll('+', '')}';
    }
    return s;
  }

  @override
  Widget build(BuildContext context) {
    Get.create<UserInfoController>(() => userInfoController, permanent: false);

    return SuperScaffold(
      // backgroundColor: AppColors.appBlackBG,
      // gradient: appMainGradient,
      showBackBtn: true,
      body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                vSpace32,
                Center(
                  child: SuperImageView(
                    imgAssetPath: AppAssets.appIcon,
                    height: Get.width * 0.3,
                    fit: BoxFit.fill,
                  ),
                ),
                vSpace24,
                Expanded(
                  child: Obx(() {
                    if (userInfoController.isEdit) {
                      return userInfoController.isTeacher ? otherUserView() : userView();
                    } else {
                      return Column(
                        children: [
                          TabBar(
                            tabs: [
                              SuperDecoratedContainer(
                                  color: userInfoController.userRole == AppConstants.roleStudent ? AppColors.appMainColor : null,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Txt(
                                        'Student',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: userInfoController.userRole == AppConstants.roleStudent ? Colors.white : null,
                                      ),
                                    ),
                                  )),
                              SuperDecoratedContainer(
                                  color: userInfoController.userRole == AppConstants.roleTeacher ? AppColors.appMainColor : null,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Txt(
                                        'Teacher',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: userInfoController.userRole == AppConstants.roleTeacher ? Colors.white : null,
                                      ),
                                    ),
                                  )),
                            ],
                            onTap: (ind) {
                              userInfoController.userRole = [AppConstants.roleStudent, AppConstants.roleTeacher][ind];
                              userInfoController.user = (UserModel());
                              mPrint('userRole = ${['AppConstants.roleStudent', 'AppConstants.roleTeacher'][ind]}');
                            },
                          ),
                          Expanded(
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                userView(),
                                otherUserView(),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                ),
              ],
            ),
          )),
    );
  }

  Widget userView() {
    return FormBuilder(
      key: userInfoController.formKey1,
      child: ListView(
        // shrinkWrap: true,
        children: [
          if (viewOnly && AppController.to.successfullyLoggedIn)
            AppButton(
              txt: 'Edit',
              fillColor: AppColors.appMainColor,
              txtColor: Colors.white,
              borderRadius: 32,
              onPressed: submitProfile,
            ),
          vSpace32,
          SuperPhoneField(
            controller: TextEditingController(
              text: (userInfoController.user.phone ?? controller.phoneNum).correctPhoneDir,
            ),
            initialDialCode: '+962',
            initialPhone: getUserPhone(),
            enableDebug: false,
            enabled: false,
          ),
          vSpace16,
          SuperEditText(
            userInfoController.nameController,
            enabled: !viewOnly,
            hint: 'Full name',
            onChanged: (s) {
              userInfoController.user.first_name = s;
            },
            // prefixIconData: Icons.person,
            // fillColor: AppColors.authBgColor,
            validators: [
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(2),
              FormBuilderValidators.maxLength(100),
            ],
          ),
          vSpace16,
          // SuperEditText(
          //   userInfoController.emailController,
          //   enabled: !viewOnly && !controller.successfullyLoggedIn,
          //   hint: AppStrings.emailHint,
          //   prefixIconData: Icons.email,
          //   textAlign: TextAlign.left,
          //   textDirection: TextDirection.ltr,
          //   onChanged: (s) {
          //     userInfoController.user.email = s;
          //   },
          //   // fillColor: AppColors.authBgColor,
          //   validators: [
          //     FormBuilderValidators.email(),
          //   ],
          // ),
          // vSpace16,
          vSpace16,
          SuperRadioGroup(
              items: const [true, false],
              itemAsString: (b) => b ? 'Male' : 'Female',
              enabled: !viewOnly && !controller.successfullyLoggedIn,
              hint: 'Gender',
              wrapAlignment: WrapAlignment.spaceAround,
              initialValue: userInfoController.user.gender,
              onChanged: (g) {
                userInfoController.user.gender = g;
              }),
          vSpace4,
          const Center(child: Txt('Hint: gender is taken to filter the teachers if you need', color: AppColors.appMainColor)),
          vSpace48,
          if (!viewOnly)
            AppButton(
              txt: 'Submit',
              fillColor: AppColors.appMainColor,
              txtColor: Colors.white,
              borderRadius: 32,
              onPressed: submitProfile,
            ),
          AppHelpers.appDivider(60),
          if (AppController.to.successfullyLoggedIn)
            AppButton(
              txt: 'Delete my account!',
              fillColor: viewOnly ? Colors.grey : Colors.red,
              txtColor: Colors.white,
              onPressed: viewOnly ? () {} : deleteProfile,
            ),
          vSpace96,
        ],
      ),
    );
  }

  Widget otherUserView() {
    return FormBuilder(
      key: userInfoController.formKey2,
      child: ListView(
          // shrinkWrap: true,
          children: const []),
    );
  }

  GlobalKey<FormBuilderState> get curFormKey =>
      userInfoController.userRole == AppConstants.roleStudent ? userInfoController.formKey1 : userInfoController.formKey2;

  void submitProfile() {
    if (viewOnly) {
      Get.to(() => UserProfilePage(user: controller.mUser), preventDuplicates: false);
      return;
    }
    if (!(curFormKey.currentState?.validate() ?? false)) {
      mPrint('Wrong credentials');
      mShowToast('Please fill all fields!');
    } else {
      mPrint('Logged in: ${controller.successfullyLoggedIn}');
      // return;
      showConfirmationDialog(function: () async {
        if (controller.successfullyLoggedIn) {
          await userInfoController.submitUpdate();
        } else {
          await userInfoController.submitRegistration();
        }
        mHide();
      });
    }
  }

  Future<void> deleteProfile() async {
    showConfirmationDialog(
        msg: 'delete your account',
        function: () {
          mShowLoading(msg: 'Deleting your account...');
          controller.deleteMyAccount();
          mHide();
        });
  }
}
