
import 'package:get/get.dart';

class EmailPreferencesController extends GetxController {
  var switchOneState = false;
  var switchTwoState = false;

  void toggleSwitchOne() {
    switchOneState = !switchOneState;
    update();
  }

  void toggleSwitchTwo() {
    switchTwoState = !switchTwoState;
    update();
  }
}