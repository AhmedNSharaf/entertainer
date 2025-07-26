import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/utils/helpers.dart';

import '../../../core/repositories/api_service.dart';
import '../../../core/routes/app_pages.dart';
import '../../models/api_response.dart';
import 'vars_mixin.dart';

mixin ConnectivityMixin on VarsMixin {
  bool isFirst = true;
  StreamSubscription? connectionStream;

  Future<void> initConnectivity() async {
    List<ConnectivityResult> result =
        await Connectivity().checkConnectivity().timeout(5.seconds).onError((error, stackTrace) => [ConnectivityResult.none]);
    isConnected = (result
        .toSet()
        .intersection({ConnectivityResult.ethernet, ConnectivityResult.wifi, ConnectivityResult.vpn, ConnectivityResult.mobile}).isNotEmpty);

    connectionStream ??= Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) async {
      isConnected = (result
          .toSet()
          .intersection({ConnectivityResult.ethernet, ConnectivityResult.wifi, ConnectivityResult.vpn, ConnectivityResult.mobile}).isNotEmpty);
      mPrint(isConnected ? 'Network Connected' : 'Network disconnected');
      changeConnectivityNavigation(isConnected);
      if (!isFirst) {
        mShowToast(
          isConnected ? 'Network Connected' : 'Network disconnected',
          displayTime: (isConnected ? 1000 : 2000).milliseconds,
        );
      }
      isFirst = false;
    });
  }

  Future<bool> realConnected([int seconds = 10]) async {
    try {
      // ApiResponse apiResponse = await ApiService.to.getDataFromUrl('https://www.google.com/');
      ApiResponse apiResponse = await ApiService.to.getDataFromUrl('https://www.google.com/').timeout(seconds.seconds);
      return apiResponse.success;
    } on Exception catch (e) {
      mPrintError('checkRealConnectivity Exception $e');
      return false;
    }
  }

  Future<void> changeConnectivityNavigation(bool isConnected) async {
    if (isConnected && Get.currentRoute == Routes.NOCONNECTION) {
      if (Get.context != null && Navigator.of(Get.context!).canPop()) {
        Get.back();
      } else {
        if (successfullyLoggedIn) {
          Get.offAllNamed(Routes.HOME);
          // bool b = await FirebaseService.checkIsBlocked();
          // if (!b) {
          //   Get.offAllNamed(Routes.HOME);
          // } else {
          //   Get.offAll(() => const BlockedPage());
          // }
        } else {
          Get.offAllNamed(Routes.LOGIN);
        }
      }
    }
  }

  Future<void> checkConnectivityNavigation() async {
    List<ConnectivityResult> result =
        await Connectivity().checkConnectivity().timeout(5.seconds).onError((error, stackTrace) => [ConnectivityResult.none]);
    isConnected = (result
        .toSet()
        .intersection({ConnectivityResult.ethernet, ConnectivityResult.wifi, ConnectivityResult.vpn, ConnectivityResult.mobile}).isNotEmpty);
    mPrint('check isConnected = $isConnected');
    mShowToast(
      isConnected ? 'Network Connected' : 'Network disconnected',
      displayTime: (isConnected ? 500 : 1000).milliseconds,
    );
    changeConnectivityNavigation(isConnected);
  }
}
