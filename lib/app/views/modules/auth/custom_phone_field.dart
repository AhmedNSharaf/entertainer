import 'package:enter_tainer/app/views/modules/auth/arab_countries_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// قائمة مرتبة للدول العربية
final List<Map<String, String>> arabCountriesList = arabCountries.entries
    .map((entry) => {
          'iso': entry.key,
          'name': entry.value['name']!,
          'nameEn': entry.value['nameEn']!,
          'code': entry.value['code']!,
          'flag': entry.value['flag']!,
        })
    .toList();

class CustomArabPhoneField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialDialCode;
  final String? initialPhone;
  final Function(String)? onPhoneChanged;
  final Function(String)? onCountryChanged;
  final Function(String?)? onFullPhoneChanged;
  final String? hintText;
  final bool enabled;
  final String? Function(String?)? validator;

  const CustomArabPhoneField({
    Key? key,
    this.controller,
    this.initialDialCode = '+962',
    this.initialPhone,
    this.onPhoneChanged,
    this.onCountryChanged,
    this.onFullPhoneChanged,
    this.hintText = 'رقم الهاتف',
    this.enabled = true,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomArabPhoneField> createState() => _CustomArabPhoneFieldState();
}

class _CustomArabPhoneFieldState extends State<CustomArabPhoneField> {
  late TextEditingController _phoneController;
  String _selectedCountryCode = '+962';
  String _selectedCountryIso = 'JO';
  Map<String, String>? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _phoneController = widget.controller ?? TextEditingController();
    
    // تحديد الدولة الافتراضية
    _selectedCountryCode = widget.initialDialCode ?? '+962';
    _findCountryByCode(_selectedCountryCode);
    
    if (widget.initialPhone != null && widget.initialPhone!.isNotEmpty) {
      _phoneController.text = widget.initialPhone!;
    }

    _phoneController.addListener(_onPhoneNumberChanged);
  }

  void _findCountryByCode(String code) {
    for (var country in arabCountriesList) {
      if (country['code'] == code) {
        _selectedCountry = country;
        _selectedCountryIso = country['iso']!;
        break;
      }
    }
    
    // إذا لم نجد الدولة، استخدم الأردن كافتراضي
    if (_selectedCountry == null) {
      _selectedCountry = arabCountriesList.firstWhere(
        (country) => country['iso'] == 'JO',
        orElse: () => arabCountriesList.first,
      );
      _selectedCountryCode = _selectedCountry!['code']!;
      _selectedCountryIso = _selectedCountry!['iso']!;
    }
  }

  void _onPhoneNumberChanged() {
    final phoneNumber = _phoneController.text;
    widget.onPhoneChanged?.call(phoneNumber);
    
    if (phoneNumber.isNotEmpty) {
      final fullPhoneNumber = _selectedCountryCode + phoneNumber;
      widget.onFullPhoneChanged?.call(fullPhoneNumber);
    } else {
      widget.onFullPhoneChanged?.call(null);
    }
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'اختر الدولة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Countries List
              Expanded(
                child: ListView.builder(
                  itemCount: arabCountriesList.length,
                  itemBuilder: (context, index) {
                    final country = arabCountriesList[index];
                    final isSelected = country['iso'] == _selectedCountryIso;
                    
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          country['flag']!,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      title: Text(
                        country['name']!,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Theme.of(context).primaryColor : null,
                        ),
                      ),
                      subtitle: Text(country['nameEn']!),
                      trailing: Text(
                        country['code']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[600],
                        ),
                      ),
                      selected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedCountry = country;
                          _selectedCountryCode = country['code']!;
                          _selectedCountryIso = country['iso']!;
                        });
                        widget.onCountryChanged?.call(_selectedCountryIso);
                        _onPhoneNumberChanged(); // تحديث الرقم الكامل
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String? _validatePhoneNumber(String? value) {
    if (widget.validator != null) {
      return widget.validator!(value);
    }
    
    if (value == null || value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    }
    
    // التحقق من أن الرقم يحتوي على أرقام فقط
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'رقم الهاتف يجب أن يحتوي على أرقام فقط';
    }
    
    // التحقق من الطول (يمكن تخصيصه حسب الدولة)
    if (value.length < 7) {
      return 'رقم الهاتف قصير جداً';
    }
    
    if (value.length > 15) {
      return 'رقم الهاتف طويل جداً';
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _phoneController,
      enabled: widget.enabled,
      keyboardType: TextInputType.phone,
      textDirection: TextDirection.ltr,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(15),
      ],
      validator: _validatePhoneNumber,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          // textDirection: TextDirection.rtl,
        ),
        prefixIcon: InkWell(
          onTap: widget.enabled ? _showCountryPicker : null,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: IntrinsicWidth(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedCountry?['flag'] ?? '🇯🇴',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _selectedCountryCode,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _phoneController.dispose();
    }
    super.dispose();
  }
}