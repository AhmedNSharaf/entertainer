import 'package:enter_tainer/app/views/modules/auth/custom_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PhoneFieldController extends GetxController {
  final TextEditingController phoneController = TextEditingController();

  String selectedCountryCode = '+962';
  String selectedCountryIso = 'JO';
  Map<String, String>? selectedCountry;

  @override
  void onInit() {
    super.onInit();
    _findCountryByCode(selectedCountryCode);
  }

  void _findCountryByCode(String code) {
    for (var country in arabCountriesList) {
      if (country['code'] == code) {
        selectedCountry = country;
        selectedCountryIso = country['iso']!;
        break;
      }
    }

    if (selectedCountry == null) {
      selectedCountry = arabCountriesList.firstWhere(
        (country) => country['iso'] == 'JO',
        orElse: () => arabCountriesList.first,
      );
      selectedCountryCode = selectedCountry!['code']!;
      selectedCountryIso = selectedCountry!['iso']!;
    }

    update();
  }

  void setCountry(Map<String, String> country) {
    selectedCountry = country;
    selectedCountryCode = country['code']!;
    selectedCountryIso = country['iso']!;
    update();
  }

  void clear() {
    phoneController.clear();
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
