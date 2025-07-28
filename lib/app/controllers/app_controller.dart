import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:neuss_utils/utils/helpers.dart';

import '../../core/services/offline_storage.dart';
import '../../core/services/super_notification_service.dart';
import 'mixins/auth_mixin.dart';
import 'mixins/connectivity_mixin.dart';
import 'mixins/home_mixin.dart';
import 'mixins/users_mixin.dart';
import 'mixins/vars_mixin.dart';

class AppController extends GetxService with VarsMixin, ConnectivityMixin, HomeMixin, AuthMixin, UsersMixin {
  static AppController get to => Get.find();

  // Add email property for email registration support
  String? email;

  @override
  void onReady() {
    initAll().whenComplete(() {
      (1).seconds.delay(() {
        if (successfullyLoggedIn) {
          mShowToast('${'Welcome back'.tr} ${mUser!.first_name}', color: Colors.green);
        }
      });
    });

    super.onReady();
  }

  Future<void> initAll() async {
    saveUserPermanently = (OfflineStorage.getUser() != null);
    await initAuth();
    await initConnectivity();
    await initLoggedIn();
  }

  Future<void> initLoggedIn() async {
    Future<void> func() async {
      mPrint("Starting initialize");
      bool b = await syncMyUser();
      if (b) await checkFCMToken();
      mPrint("Successfully initialized");
    }

    if (successfullyLoggedIn) {
      await refreshToken().then((b) async {
        if (b) {
          await func();
        } else {
          await refreshToken().then((b) async {
            if (b) {
              await func();
            } else {
              // AppHelpers.restartApp();
            }
          });
        }
      });
    }
  }

  Future<void> checkFCMToken() async {
    if (!successfullyLoggedIn) return;
    String token = await SuperNotificationService.to.getFirebaseMessagingToken();
    if (!token.isNullOrEmptyOrWhiteSpace && token != mUser!.fcm_token) {
      SuperNotificationService.myFcmTokenHandle(token);
    }
  }

  // Helper method to check if user is registering with email
  bool get isUsingEmail => email != null && email!.isNotEmpty;

  // Helper method to get the contact info (phone or email)
  String get contactInfo {
    if (isUsingEmail) {
      return email!;
    } else {
      return phoneNum;
    }
  }

  // Helper method to get verification type
  String get verificationType {
    if (isUsingEmail) {
      return 'email';
    } else {
      return 'phone';
    }
  }

  // Method to clear registration data
  void clearRegistrationData() {
    email = null;
    phoneNum = '';
  }

  // Method to set registration method
  void setRegistrationMethod({String? emailAddress, String? phoneNumber, required String userType}) {
    if (emailAddress != null && emailAddress.isNotEmpty) {
      email = emailAddress;
      phoneNum = '';
    } else if (phoneNumber != null && phoneNumber.isNotEmpty) {
      phoneNum = phoneNumber;
      email = null;
    }
  }
  

  @override
  void onClose() {
    connectionStream?.cancel();
    tabController?.dispose();
    connectionStream = null;
    tabController = null;
    mPrint('onClose onClose onClose');

    super.onClose();
  }
}
