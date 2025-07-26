import 'dart:async';

import 'package:get/get.dart';
import 'package:neuss_utils/utils/helpers.dart';
import 'package:ready_extensions/ready_extensions.dart';

import '../../../core/repositories/api_service.dart';
import '../../../core/services/offline_storage.dart';
import '../../models/user_model.dart';
import 'vars_mixin.dart';

mixin UsersMixin on VarsMixin {
  Future<bool> syncMyUser() async {
    UserModel? user = await ApiService.to.getMyUser();
    if (user != null) {
      mUser = user;
      refreshUser();
      if (saveUserPermanently) {
        OfflineStorage.saveUser(mUser!);
      }
      return true;
    }
    return false;
  }

  Future<bool> updateMyUser(Map<String, dynamic> map) async {
    if (mUser != null) {
      UserModel? userModel = await ApiService.to.updateMyUser(map);
      if (userModel != null) {
        mPrint('Updated Successfully');
        mUser!.updateFrom(another: userModel);
        if (saveUserPermanently) {
          OfflineStorage.saveUser(mUser!);
        }
        return true;
      } else {
        mPrint('Failed');
        // mShowToast('Failed');
      }
    }
    return false;
  }

  Future<void> updateMyFCMToken(String? token) async {
    if (successfullyLoggedIn && mUser?.fcm_token != token) {
      updateMyUser({UserModelFields.fcm_token: token});
    }
  }

  Future<void> refreshMyTokenTimer() async {
    mPrint('refreshMyTokenTimer');
    refreshTokenTimer?.cancel();
    refreshTokenTimer = Timer.periodic(10.minutes, (timer) => [refreshToken(), mPrint('refreshMyTokenTimer call ${timer.tick}')]);
  }

  Future<bool> refreshToken() async {
    if (!successfullyLoggedIn) return false;

    mPrint('refreshing my Token 1');
    authTokensModel ??= OfflineStorage.getAuthToken();

    if (authTokensModel == null && !OfflineStorage.getMyPassword().isNullOrEmptyOrWhiteSpace) {
      authTokensModel = await ApiService.to.login(mUser?.email, OfflineStorage.getMyPassword());
    } else if (authTokensModel?.refreshToken != null) {
      authTokensModel = await ApiService.to.refreshToken();
    }
    mPrint('refreshing my Token 2');
    if (saveUserPermanently) {
      OfflineStorage.saveAuthToken(authTokensModel);
    }
    mPrint('authTokensModel = $authTokensModel');
    return authTokensModel != null;
  }
}
