import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/image_utils/src/super_image_class.dart';
import 'package:neuss_utils/utils/helpers.dart';
import 'package:ready_extensions/ready_extensions.dart';

import '../../core/repositories/api_service.dart';
import '../../core/routes/app_pages.dart';
import '../../core/services/offline_storage.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/app_helpers.dart';
import '../models/user_model.dart';
import '../views/modules/auth/user_profile_screen.dart';
import 'app_controller.dart';

class UserInfoController extends GetxService {
  static UserInfoController get to => Get.find();

  UserInfoController([UserModel? model]) {
    if (model != null) {
      isEdit = true;
      user = model.copyWith();
      mPrint({'User': user.toMap()});
      userRole = user.role ?? AppConstants.roleStudent;
      nameController.text = user.first_name ?? '';
      if (user.email?.contains(AppConstants.defaultEmail) == false) {
        emailController.text = user.email ?? '';
      }
      avatarImage.setImgString(AppHelpers.getServerImageUrl(user.avatar));
    } else {
      user.phone = AppController.to.phoneNum;
    }
  }

  ///region Vars

  final _isEdit = false.obs;

  bool get isEdit => _isEdit.value;

  set isEdit(bool val) => _isEdit.value = val;

  final _user = (UserModel()).obs;

  UserModel get user => _user.value;

  set user(UserModel val) => {_user.value = val, _user.refresh()};

  final GlobalKey<FormBuilderState> formKey1 = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> formKey2 = GlobalKey<FormBuilderState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController workingPlaceController = TextEditingController();
  final TextEditingController workingYearsController = TextEditingController();
  final TextEditingController workingAppsController = TextEditingController();
  final TextEditingController childrenTeachingController = TextEditingController();
  final TextEditingController countryOfResidenceController = TextEditingController();
  final TextEditingController countryOfNationalityController = TextEditingController();

  final SuperImageClass avatarImage = SuperImageClass();

  final _userRole = AppConstants.roleStudent.obs;

  String get userRole => _userRole.value;

  set userRole(String val) => _userRole.value = val;

  bool get isTeacher => userRole == AppConstants.roleTeacher;

  ///endregion

  void refreshUser() {
    _user.refresh();
  }

  Future<bool> submitRegistration() async {
    mShowLoading(msg: 'Registering...');
    UserModel submitUser = user.copyWith(
      phone: AppController.to.phoneNum,
      password: AppController.to.authModel.password,
      role: userRole,
    );

    submitUser.status = 'active';
    mPrint({'submit User: ': submitUser.toJson()});

    // return false;
    UserModel? userModel = await ApiService.to.createUser(submitUser);
    if (userModel == null) {
      mShowToast('User not created');
      mPrintError('User not created');
      return false;
    }
    mPrint('User Created: *******/n ${userModel.toJson()}    /n*******');

    mShowLoading();
    AppController.to.mUser = userModel.copyWith(password: AppController.to.authModel.password);
    OfflineStorage.saveMyPassword(AppController.to.authModel.password!);

    await AppController.to.refreshToken();

    if (avatarImage.changed && avatarImage.file != null) {
      String? avatarID = await ApiService.to.uploadImage(avatarImage.file!);
      if (avatarID != null) {
        await AppController.to.updateMyUser({UserModelFields.avatar: avatarID});
      }
    }

    bool b = await AppController.to.syncMyUser();
    if (b) {
      await AppController.to.afterOtpPassed('Registered Successfully');
      10.milliseconds.delay(() {
        mHide();
        Get.toNamed(Routes.HOME);
      });
      return true;
    }
    mHide();
    return false;
  }

  Future<bool> submitUpdate() async {
    UserModel submitUser = user.copyWith();

    mPrint({'User': submitUser.toJson()});

    // return false;

    mShowLoading(msg: 'Updating...');
    Map<String, dynamic> userMap = submitUser.toMap();

    if (!emailController.text.trim().isNullOrEmptyOrWhiteSpace && !emailController.text.contains(AppConstants.defaultEmail)) {
      userMap[UserModelFields.email] = emailController.text.trim();
    }

    mPrint('userMap = ${jsonEncode(userMap)}');

    if (avatarImage.changed && avatarImage.file != null) {
      String? avatarID = await ApiService.to.uploadImage(avatarImage.file!);
      if (avatarID != null) userMap[UserModelFields.avatar] = avatarID;
    }

    if (await AppController.to.updateMyUser(userMap)) {
      refreshUser();

      await AppController.to.syncMyUser();

      mHide();

      mPrint('Updated Successfully');
      mShowToast('Updated Successfully');
      hideKeyboard(Get.context);

      10.milliseconds.delay(() {
        Get.back();
        Get.off(() => UserProfilePage(user: AppController.to.mUser, viewOnly: true), preventDuplicates: false);
      });
    } else {
      mShowToast('Failed');
    }

    return true;
  }
}
