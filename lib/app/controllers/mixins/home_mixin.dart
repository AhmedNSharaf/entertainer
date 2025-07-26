import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/utils/helpers.dart';

import '../../../core/routes/app_pages.dart';
import 'vars_mixin.dart';

mixin HomeMixin on VarsMixin {
  FutureOr<void> onWillPop(result) async {
    Completer<bool> completer = Completer();

    if (isDialogShown) {
      mPrint('1 1');
      mHide();
      completer.complete(false);
    } else if (Get.currentRoute != Routes.HOME) {
      // mPrint('1');
      Get.back();
    } else {
      if (selectedBottomBarIndex == 2) {
        // mPrint('3');
        // return true;
        // exit(0);
      } else {
        // mPrint('4');
        updateIndex(2);
      }
    }
  }

  Future<void> goToHome() async {
    Get.back();
    while (Get.context != null &&
        ModalRoute.of(Get.context!)?.settings.name != null &&
        ModalRoute.of(Get.context!)?.settings.name != "/home") {
      Get.back();
    }
    updateIndex(2);
  }

  void updateIndex(index) {
    selectedBottomBarIndex = index;
    tabController?.animateTo(selectedBottomBarIndex, duration: 100.milliseconds, curve: Curves.bounceIn);
  }

  Future<void> onNavigateBtnTap(int n) async {
    selectedBottomBarIndex = n;
    tabController?.animateTo(selectedBottomBarIndex, duration: 100.milliseconds, curve: Curves.bounceIn);
  }
}