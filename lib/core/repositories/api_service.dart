import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:neuss_utils/utils/helpers.dart';
import 'package:ready_extensions/ready_extensions.dart';

import '../../app/controllers/app_controller.dart';
import '../../app/models/api_response.dart';
import '../../app/models/auth_tokens_model.dart';
import '../../app/models/user_model.dart';
import '../utils/app_constants.dart';
import '_base_api_service.dart';

class ApiService extends BaseApiService implements GetxService {
  static ApiService get to => Get.find();

  ///region Authentication
  ///************************************************************************************************
  Future<AuthTokensModel?> login(var email, var pass) async {
    ApiResponse apiResponse = await postData('auth/login', jsonEncode({"email": email, "password": pass}));
    if (apiResponse.success) {
      AuthTokensModel authTokensModel = AuthTokensModel.fromMap(apiResponse.data);
      mPrint('authTokensModel: $authTokensModel');
      return authTokensModel;
    }
    return null;
  }

  Future<AuthTokensModel?> refreshToken() async {
    if (AppController.to.authTokensModel?.refreshToken == null) return null;
    ApiResponse apiResponse = await postData('auth/refresh', jsonEncode({"refresh_token": AppController.to.authTokensModel?.refreshToken}));
    if (apiResponse.success) {
      AuthTokensModel authTokensModel = AuthTokensModel.fromMap(apiResponse.data);
      mPrint('authTokensModel: $authTokensModel');
      return authTokensModel;
    }
    return null;
  }

  Future<bool> deleteMyUser() async {
    if (!AppController.to.successfullyLoggedIn) {
      mPrintError('Not logged in');
      mShowToast('Not logged in');
      return false;
    }
    ApiResponse apiResponse = await getData("files?filter[uploaded_by][_eq]=${AppController.to.mUser!.id}");
    if (apiResponse.success) {
      for (var file in (apiResponse.data as List)) {
        apiResponse = await deleteData("files/${file['id']}");
        if (apiResponse.failed) {
          return false;
        }
      }
      apiResponse = await deleteData("users/${AppController.to.mUser!.id}");
      return apiResponse.success;
    }
    return false;
  }

  Future<UserModel?> createUser(UserModel userModel) async {
    userModel.phone = userModel.phone?.replaceAll('+', '');
    if (userModel.email.isNullOrEmptyOrWhiteSpace) {
      userModel.email = '${userModel.phone}${AppConstants.defaultEmail}';
    }
    ApiResponse apiResponse = await postData("users", userModel.toJson());
    if (apiResponse.success) {
      return UserModel.fromMap(apiResponse.data);
    }
    return null;
  }

  Future<UserModel?> updateMyUser(Map<String, dynamic> map) async {
    if (!AppController.to.successfullyLoggedIn || AppController.to.mUser!.id == null) {
      mPrintError('Not logged in');
      mShowToast('Not logged in');
      return null;
    }
    map.remove('id');
    if (map[UserModelFields.password] != null && map[UserModelFields.password].toString().contains('*****')) {
      map.remove(UserModelFields.password);
    }
    ApiResponse apiResponse = await patchData("users/${AppController.to.mUser!.id}", jsonEncode(map));
    if (apiResponse.success) {
      UserModel user = UserModel.fromMap(apiResponse.data);
      return user;
    }
    return null;
  }

  Future<UserModel?> updateMyPassword(String newPass) async {
    if (newPass.isNullOrEmptyOrWhiteSpace) {
      mPrintError('Password empty');
      mShowToast('Password empty');
      return null;
    }
    ApiResponse apiResponse = await patchData("users/${AppController.to.mUser!.id}", jsonEncode({UserModelFields.password: newPass}));
    if (apiResponse.success) {
      UserModel user = UserModel.fromMap(apiResponse.data);
      return user;
    }
    return null;
  }

  Future<UserModel?> getUserByPhone(String phone) async {
    var resp = await ApiService.to.queryUserByPhone(phone);
    return resp.$2;
  }

  Future<(ApiResponse?, UserModel?)> queryUserByPhone(String phone) async {
    phone = phone.replaceAll('+', '');
    ApiResponse apiResponse = await getData("users?filter[phone][_eq]=$phone");

    if (apiResponse.success) {
      try {
        List dataList = (apiResponse.data as List);
        if (dataList.length == 1) {
          return (apiResponse, UserModel.fromMap(dataList.first));
        } else {
          mPrint('returned list.length = ${dataList.length}');
          return (apiResponse, null);
        }
      } catch (e) {
        mPrintError("Exception: $e");
      }
    }

    return (apiResponse, null);
  }

  ///************************************************************************************************
  ///endregion Authentication

  ///region Helpers
  ///************************************************************************************************
  Future<UserModel?> getMyUser() async {
    try {
      if (AppController.to.mUser?.id == null) {
        mPrintError('Not logged in');
        mShowToast('Not logged in');
        return null;
      }
      ApiResponse apiResponse = await getData("users/me");
      if (apiResponse.success) {
        return UserModel.fromMap(apiResponse.data);
      }
    } catch (e) {
      mPrintError("Exception: $e");
    }
    return null;
  }

  Future<List<UserModel>> getUsersWithInfoByRole(String role) async {
    ApiResponse apiResponse = await getData("users?fields=*.*&filter[role]=$role");

    if (apiResponse.success) {
      return UserModel.fromMapList(apiResponse.data as List);
    }
    return [];
  }

  Future<List<UserModel>> getAllStudents() async {
    try {
      return await getUsersWithInfoByRole(AppConstants.roleStudent);
    } catch (e) {
      mPrintError("Exception: $e");
    }
    return [];
  }

  Future<List<UserModel>> getAllTeachers() async {
    try {
      return await getUsersWithInfoByRole(AppConstants.roleTeacher);
    } catch (e) {
      mPrintError("Exception: $e");
    }
    return [];
  }

  ///************************************************************************************************
  ///endregion Helpers

  ///region Fav Items

  Future<dynamic> getUser(String userID) async {
    return (await getSingleModel(UserModel, userID)) as UserModel?;
  }

  Future<dynamic> getSingleModel(dynamic modelName, String id) async {
    ApiResponse apiResponse = await getData('${modelName.tableName}/$id');
    if (apiResponse.success) {
      return modelName.fromMap(apiResponse.data);
    }
    return null;
  }

  ///endregion Fav Items
}
