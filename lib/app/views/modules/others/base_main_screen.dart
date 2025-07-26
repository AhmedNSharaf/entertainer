import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/widgets/src/super_scaffold.dart';
import 'package:neuss_utils/widgets/src/txt.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../controllers/app_controller.dart';

class BaseMainScreen extends GetView<AppController> {
  const BaseMainScreen({
    required this.title,
    required this.child,
    this.preferredAppBar,
    this.scaffoldKey,
    this.drawer,
    super.key,
  });

  final String title;
  final Widget child;
  final PreferredSizeWidget? preferredAppBar;
  final Widget? drawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  static String newStatus = AppConstants.statusUnAvailable;

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      key: scaffoldKey,
      onWillPop: controller.onWillPop,
      appBar:
          preferredAppBar ?? // Use custom AppBar if provided
          AppBar(title: Txt(title, fontSize: 24, fontWeight: FontWeight.bold)),
      drawer: drawer,
      body: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }
}
