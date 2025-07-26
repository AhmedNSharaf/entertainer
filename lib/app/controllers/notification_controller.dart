import 'package:get/get.dart';

class NotificationController extends GetxController {
  var notificationsEnabled = false;

  void toggleNotifications() {
    notificationsEnabled = !notificationsEnabled;
    update();
  }
}