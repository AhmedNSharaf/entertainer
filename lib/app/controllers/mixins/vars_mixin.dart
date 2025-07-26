import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_constants.dart';
import '../../models/admin_data_model.dart';
import '../../models/auth_tokens_model.dart';
import '../../models/user_model.dart';

mixin VarsMixin on GetxService {
  ///region Vars
  String verificationIDFromFirebase = '';
  String? newPass;

  FirebaseAuth mAuth = FirebaseAuth.instance;

  Timer? refreshTokenTimer;

  final _tabController = Rxn<TabController>();

  TabController? get tabController => _tabController.value;

  set tabController(TabController? val) => _tabController.value = val;

  final _selectedIndex = 0.obs;

  int get selectedBottomBarIndex => _selectedIndex.value;

  set selectedBottomBarIndex(int val) => _selectedIndex.value = val;

  bool get isAdmin =>
      successfullyLoggedIn && mUser!.role == AppConstants.roleAdmin;

  bool get isDriver =>
      successfullyLoggedIn && mUser!.role == AppConstants.roleDriver;

  bool get isCustomer =>
      successfullyLoggedIn && mUser!.role == AppConstants.roleCustomer;

  bool get successfullyLoggedIn => mUser?.id != null;

  bool get successfullyLoggedInFirebase => mAuth.currentUser != null;
  final _adminDataModel =
      AdminDataModel(
        Donation_WA_Message: AppConstants.defaultWhatsAppMsg,
        Donation_WA_Message_ar: AppConstants.defaultWhatsAppMsg,
        Support_WA_Message: AppConstants.defaultWhatsAppMsg,
        Support_WA_Message_ar: AppConstants.defaultWhatsAppMsg,
        Donation_WA_number: AppConstants.defaultWhatsAppNum,
        Support_WA_number: AppConstants.defaultWhatsAppNum,
      ).obs;

  AdminDataModel get adminDataModel => _adminDataModel.value;

  set adminDataModel(AdminDataModel val) => _adminDataModel.value = val;
  // final RxString _whatsAppNum = AppConstants.defaultWhatsAppNum.obs;
  //
  // String get whatsAppNum => _whatsAppNum.value;
  //
  // set whatsAppNum(String val) => {_whatsAppNum.value = val};
  //
  // final RxString _whatsAppMsg = AppConstants.defaultWhatsAppMsg.obs;
  //
  // String get whatsAppMsg => _whatsAppMsg.value;
  //
  // set whatsAppMsg(String val) => {_whatsAppMsg.value = val};

  final RxString _phoneNum = "".obs;
  String get phoneNum => _phoneNum.value;
  set phoneNum(String val) => {_phoneNum.value = val};

  AuthStates authState = AuthStates.login;
  AuthTokensModel? authTokensModel;

  final Rxn<UserModel> _mUser = Rxn<UserModel>();
  UserModel? get mUser => _mUser.value;
  set mUser(UserModel? val) => {_mUser.value = val, _mUser.refresh()};
  String? get mUserID => mUser?.id;

  void refreshUser() {
    _mUser.refresh();
  }

  final _savePermanently = true.obs;
  bool get saveUserPermanently => _savePermanently.value;
  set saveUserPermanently(bool val) => _savePermanently.value = val;

  final _isGuest = false.obs;
  bool get isGuest => _isGuest.value;
  set isGuest(bool val) => _isGuest.value = val;

  final RxBool _isConnected = false.obs;
  bool get isConnected => _isConnected.value;
  set isConnected(bool x) => _isConnected.value = x;

  bool get isTeacher =>
      successfullyLoggedIn && mUser!.role == AppConstants.roleTeacher;
  bool get isNormalUser =>
      successfullyLoggedIn && mUser!.role == AppConstants.roleStudent;

  // bool get successfullyLoggedIn => successfullyLoggedInFirebase && mUser?.id != null;

  String? deviceID;

  ///endregion Vars
}

enum AuthStates { login, signup, otpVerify, forgotPass, profile, loggedIn }
