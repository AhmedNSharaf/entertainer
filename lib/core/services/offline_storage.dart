import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:neuss_utils/utils/helpers.dart';

import '../../app/models/admin_data_model.dart';
import '../../app/models/auth_tokens_model.dart';
import '../../app/models/user_model.dart';

class OfflineStorage {
  static final GetStorage _storage = GetStorage();

  static const String _userKey = "USER_KEY";
  static const String _tokenKey = "_tokenKey";
  static const String _myFavoritePersonsIdKey = "FavoritePersonsIdKey";
  static const String _myMyPasswordKey = "MyPasswordKey";
  static const String _authPhoneKey = "authPhoneKey";
  static const String _adminDataKey = "adminDataKey";

  ///region User
  static void saveUser(UserModel userModel) => {mPrint('Storing user $userModel'), _storage.write(_userKey, userModel.toMap())};

  static void eraseUser() => {mPrint('Erasing user'), _storage.remove(_userKey)};

  static UserModel? getUser() {
    mPrint('Reading user');
    if (_storage.hasData(_userKey)) {
      UserModel user = UserModel.fromMap(_storage.read(_userKey));
      mPrint("User = $user");
      return user;
    }
    return null;
  }

  ///endregion User

  ///region AdminData
  static void saveAdminData(AdminDataModel adminDataModel) => {mPrint('Storing AdminData $adminDataModel'), _storage.write(_adminDataKey, adminDataModel.toMap())};

  static void eraseAdminData() => {mPrint('Erasing AdminData'), _storage.remove(_adminDataKey)};

  static AdminDataModel? getAdminData() {
    mPrint('Reading AdminData');
    if (_storage.hasData(_adminDataKey)) {
      AdminDataModel adminData = AdminDataModel.fromMap(_storage.read(_adminDataKey));
      mPrint("AdminData = $adminData");
      return adminData;
    }
    return null;
  }

  ///endregion User

  ///region Token
  static void saveAuthToken(AuthTokensModel? authTokensModel) => {
        mPrint('Storing AuthTokens $authTokensModel'),
        (authTokensModel?.accessToken == null || authTokensModel?.refreshToken == null) ? eraseAuthToken() : _storage.write(_tokenKey, authTokensModel!.toMap())
      };

  static void eraseAuthToken() => {mPrint('Erasing Token'), _storage.remove(_tokenKey)};

  static AuthTokensModel? getAuthToken() {
    mPrint('Reading Auth Token');
    if (_storage.hasData(_tokenKey)) {
      AuthTokensModel authTokensModel = AuthTokensModel.fromMap(_storage.read(_tokenKey));

      mPrint("Cached Auth Token = $authTokensModel");
      return authTokensModel;
    }
    return null;
  }

  ///endregion Token

  ///region FavID
  static void saveMyFavoritePersonsId(int myFavoritePersonsId) => {mPrint('Storing FavoritePersonsId $myFavoritePersonsId'), _storage.write(_myFavoritePersonsIdKey, myFavoritePersonsId)};

  static void eraseMyFavoritePersonsId() => {mPrint('Erasing MyFavoritePersonsId'), _storage.remove(_myFavoritePersonsIdKey)};

  static int? getMyFavoritePersonsId() {
    mPrint('Reading MyFavoritePersonsId');
    if (_storage.hasData(_myFavoritePersonsIdKey)) {
      int favID = _storage.read(_myFavoritePersonsIdKey);
      mPrint("MyFavoritePersonsId = $favID");
      return favID;
    }
    return null;
  }

  ///endregion FavID

  ///region MyPassword
  static void saveMyPassword(String myPassword) => {mPrint('Storing MyPassword $myPassword'), _storage.write(_myMyPasswordKey, myPassword)};

  static void eraseMyPassword() => {mPrint('Erasing MyPassword'), _storage.remove(_myMyPasswordKey)};

  static String? getMyPassword() {
    mPrint('Reading MyPassword');
    if (_storage.hasData(_myMyPasswordKey)) {
      String pass = _storage.read(_myMyPasswordKey);
      mPrint("MyPassword = $pass");
      return pass;
    }
    return null;
  }

  ///endregion FavID

  ///region Authed Phones
  static void addAuthPhone(String phone) {
    phone = phone.replaceAll("+", "");
    mPrint('Adding AuthPhone $phone');

    Set phones = getAuthPhones() ?? {};
    phones.add(phone);
    mPrint('phones = $phones');
    _storage.write(_authPhoneKey, jsonEncode(<String>[...phones]));
  }

  static bool checkAuthPhone(String phone) {
    phone = phone.replaceAll("+", "");
    mPrint('Checking AuthPhone $phone');
    Set phones = getAuthPhones() ?? {};
    return phones.contains(phone);
  }

  static void removeAuthPhone(String phone) {
    phone = phone.replaceAll("+", "");
    mPrint('Erasing AuthPhone $phone');
    Set phones = getAuthPhones() ?? {};
    phones.remove(phone);
    _storage.write(_authPhoneKey, jsonEncode(<String>[...phones]));
  }

  static void eraseAuthPhones() => {mPrint('Erasing eraseAuthPhones'), _storage.remove(_authPhoneKey)};

  static Set? getAuthPhones() {
    mPrint('Reading AuthPhones');
    if (_storage.hasData(_authPhoneKey)) {
      Set phones = (jsonDecode(_storage.read(_authPhoneKey))).toSet();
      mPrint("phones = $phones");
      return phones;
    }
    return null;
  }

  ///endregion Authed Phones

  static void eraseAll() => {eraseUser(), eraseMyPassword(), eraseAuthToken(), eraseMyFavoritePersonsId()};
}
