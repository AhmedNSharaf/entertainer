import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/utils/helpers.dart';
import 'package:ready_extensions/ready_extensions.dart';

import '../../../core/repositories/api_service.dart';
import '../../../core/routes/app_pages.dart';
import '../../../core/services/offline_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../models/api_response.dart';
import '../../models/user_model.dart';
import '../../views/modules/auth/forgetpass_view.dart';
import '../app_controller.dart';
import 'home_mixin.dart';
import 'vars_mixin.dart';

mixin AuthMixin on HomeMixin {
  initAuth() {
    // OfflineStorage.eraseAll();
    mUser = OfflineStorage.getUser();
    // mFireUser = mAuth.currentUser;
    // if (mUser == null && successfullyLoggedInFirebase) {
    //   mAuth.signOut();
    //   mFireUser = null;
    // }
  }

  verifyUserPhone(UserModel userModel, AuthStates authStat, {bool forceOTP = false}) async {
    authState = authStat;
    mPrint('Verifying $userModel');

    phoneNum = userModel.phone!;
    authModel = userModel.copyWith();

    (ApiResponse?, UserModel?) userQuery = await ApiService.to.queryUserByPhone(userModel.phone!);
    mPrint('ApiResponse ${userQuery.$1}');
    mPrint('UserModel ${userQuery.$2}');

    mPrint('Checking user first');

    UserModel? user = userQuery.$2;

    if (userQuery.$1 == null || userQuery.$1!.failed) {
      mPrintError('Failed #1, ${userQuery.$1!.errors}');
      mShowToast('Failed #1');
      mHide();
      return;
    }

    mPrint('Starting verifying ($authStat) process...');

    ///region Switch
    switch (authStat) {
      case AuthStates.forgotPass:
        if (user == null) {
          mPrintError('User with this phone not found, sign up');
          mShowToast('User with this phone not found, sign up');
          mHide();
          Get.offNamed(Routes.SIGNUP);
          return;
        }
        break;
      case AuthStates.signup:
        if (user?.id != null) {
          mHide();
          mPrintError('User already exist, login');
          mShowToast('User already exist, login');
          return;
        }
        break;
      case AuthStates.login:
        if (user == null) {
          mPrintError('User with this phone not found, sign up');
          mShowToast('User with this phone not found, sign up');
          mHide();
          Get.offNamed(Routes.SIGNUP);
          return;
        }
        authTokensModel = await ApiService.to.login(userQuery.$2!.email, authModel.password);
        if (authTokensModel?.accessToken == null) {
          mHide();
          mPrintError('Invalid password');
          mShowToast('Invalid password');
          return;
        } else {
          mUser = user.copyWith(password: authModel.password);
          bool b = await AppController.to.syncMyUser();
          mPrint('syncMyUser 1 ($b)');
          if (b) {
            afterOtpPassed('Logged in successfully');
            OfflineStorage.saveMyPassword(authModel.password!);
          } else {
            b = await AppController.to.syncMyUser();
            mPrint('syncMyUser 2 ($b)');
            if (b) {
              afterOtpPassed('Logged in successfully');
            }
            mShowToast('Unable to continue');
            return;
          }
        }
        break;
      case AuthStates.profile:
        break;
      default:
        break;
    }

    ///endregion Switch

    mPrint('phoneNum = ${userModel.phone}');
    if (!successfullyLoggedIn) {
      if (!forceOTP && OfflineStorage.checkAuthPhone(userModel.phone!) && authState != AuthStates.forgotPass) {
        await otpPassed(userModel.phone!);
        mHide();
      } else {
        Get.toNamed(Routes.OTPVERIFY);
        _verifyPhone();
      }
    }
  }

  _verifyPhone() async {
    try {
      mShowLoading(
        msg: 'Waiting OTP code...',
        clickMaskDismiss: false,
      );
      await mAuth.verifyPhoneNumber(
        phoneNumber: authModel.phone,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          mHide();
          mPrint('verificationCompleted');
          // await mAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          mHide();
          if (e.code == 'invalid-phone-number') {
            mShowToast('The provided phone number is not valid');
            mPrintError('The provided phone number is not valid');
          } else if (e.code == 'invalid-verification-code') {
            mShowToast('The provided verification code is not valid');
            mPrintError('The provided verification code is not valid');
          } else if (e.code == 'quota-exceeded') {
            mShowToast('Sorry, the quota exceeded. Try again later');
            mPrintError('Sorry, the quota exceeded. Try again later');
          } else if (e.code == 'session-expired') {
            mShowToast('Sorry, the session expired. Try again');
            mPrintError('Sorry, the session expired. Try again');
          } else {
            mShowToast('Unable to login with this number!');
          }

          mShowToast(
            'FirebaseAuthException: $e',
            displayTime: 60.seconds,
          );
          mPrintError('FirebaseAuthException1 $e');
          Get.back();
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          mHide();
          verificationIDFromFirebase = verificationId;
          mShowToast('Code is sent...', color: Colors.green);
          mPrint('codeSent');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationIDFromFirebase = verificationId;
          mHide();
          mPrint('codeAutoRetrievalTimeout');
          // mShowToast('Timed out');
        },
      );
    } on FirebaseAuthException catch (e) {
      mHide();
      if (e.code == 'invalid-phone-number') {
        mShowToast('The provided phone number is not valid.', color: Colors.red);
        mPrintError('The provided phone number is not valid.');
      } else {}
    }
  }

  verifyOTP(String otp) async {
    mPrint('verifyOTP');
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationIDFromFirebase, smsCode: otp);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  UserModel authModel = UserModel();

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential = await mAuth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        mPrint('authState: $authState');
        otpPassed(authCredential.user?.phoneNumber);
      } else {
        mPrintError('Unable to verify your account, try again!');
        mShowToast('Unable to verify your account, try again!');
      }
    } on FirebaseAuthException catch (e) {
      mPrintError('FirebaseAuthException2: ${e.code} - ${e.message}');
      mHide();
      mShowToast(e.code);
    }
  }

  Future<void> otpPassed(String? phoneNumber) async {
    if (phoneNumber != null) {
      if (saveUserPermanently) {
        OfflineStorage.addAuthPhone(phoneNumber);
      }

      ///region Switch
      switch (authState) {
        ///region forgotPass
        case AuthStates.forgotPass:
          mHide();
          if (authModel.phone.isNullOrEmptyOrWhiteSpace) {
            mPrintError('Phone is required');
            mShowToast('Phone is required', color: Colors.red);
            Get.back();
            return;
          }
          UserModel? user = await ApiService.to.getUserByPhone(phoneNumber);
          if (user != null) {
            newPass = null;

            await showForgotPassDialog(
              onSubmit: (s) async {
                newPass = s;
                if (newPass == null) {
                  mHide();
                  mPrintError('newPass = null');
                  mShowToast('new Pass error');
                  return;
                }
                mShowLoading();
                mUser = user;
                UserModel? b = await ApiService.to.updateMyPassword(newPass!);
                if (b != null) {
                  OfflineStorage.saveMyPassword(newPass!);
                  mUser!.updateFrom(another: b);
                  mUser!.password = newPass;
                  await AppController.to.refreshToken();
                  afterOtpPassed('Password updated successfully');
                  newPass = null;
                } else {
                  mHide();
                  mUser = null;
                  mPrintError('Failed to update password');
                  mShowToast('Failed to update password');
                }
                mHide();
              },
            );
          } else {
            signOut();
            mPrintError('User not found');
          }
          break;

        ///endregion forgotPass
        ///region signup
        case AuthStates.signup:
          Get.offNamed(Routes.UserProfilePage);
          // Get.off(() => UserProfilePage(user: AppController.to.mUser,viewOnly: true), preventDuplicates: false);

          break;

        ///endregion signup
        ///region login
        case AuthStates.login:
          UserModel? user = await ApiService.to.getUserByPhone(phoneNumber);
          if (user == null) {
            mShowToast('Failed #2');
            return;
          }
          mUser = user.copyWith(password: authModel.password);
          OfflineStorage.saveMyPassword(authModel.password!);
          afterOtpPassed('Logged in successfully');

          break;

        ///endregion login
        case AuthStates.profile:
          break;
        default:
          break;
      }

      mHide();

      ///endregion Switch
    }
  }

  Future<void> afterOtpPassed(String msg) async {
    if (saveUserPermanently) {
      OfflineStorage.saveUser(mUser!);
      OfflineStorage.saveAuthToken(authTokensModel);
    } else {
      OfflineStorage.eraseAll();
      OfflineStorage.removeAuthPhone(mUser!.phone!);
    }
    try {
      hideKeyboard(Get.context);
      await AppController.to.initLoggedIn().whenComplete(() {
        mHide();
        mPrint(msg);
        mShowToast(msg, color: AppColors.appMainColor);
        Get.offAllNamed(Routes.HOME);
        authState = AuthStates.loggedIn;
      });
    } on Exception catch (e) {
      mPrintError('Exception $e');
    }
  }

  Future<void> showForgotPassDialog({required void Function(String) onSubmit}) async {
    await mShowDialog(backDismiss: false, clickMaskDismiss: false, builder: (_) => ForgetPassPage(onSubmit: onSubmit));
  }

  void signOutDialog() async {
    showConfirmationDialog(
        msg: 'Logout',
        function: () async {
          signOut();
        });
  }

  void signOut() async {
    try {
      mShowLoading();

      // await mAuth.signOut();
      await ApiService.to.updateMyUser({UserModelFields.fcm_token: ""});
      mUser = null;
      authTokensModel = null;
      saveUserPermanently = false;
      tabController = null;
      phoneNum = '';
      OfflineStorage.eraseAll();
      mPrint('Logged out successfully');
      mShowToast('Logged out successfully', color: Colors.orange);
      updateIndex(2);
      mHide();
      authState = AuthStates.login;
      Get.offAllNamed(Routes.SPLASH);
    } on Exception {
      // ApiService.reportUserProblem({'Problem': 'signOut: $e'}, loggedInUser!);
    }
  }

  deleteMyAccount() async {
    if (successfullyLoggedIn) {
      phoneNum = mUser?.phone ?? '';
      mShowLoading(msg: 'Deleting...');
      if (await ApiService.to.deleteMyUser()) {
        signOut();
        OfflineStorage.removeAuthPhone(phoneNum);
        mShowToast('Your account has been deleted');
        mPrint('Your account has been deleted');
        Get.offAllNamed(Routes.SPLASH);
      } else {
        mShowToast('Error deleting your account');
        mPrintError('Error deleting your account');
      }
    }
  }
}
