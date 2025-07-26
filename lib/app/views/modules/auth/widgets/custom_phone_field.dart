import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// نموذج الدولة
class CountryModel {
  final String name;
  final String code;
  final String dialCode;
  final String flag;

  CountryModel({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });

  @override
  String toString() => '$name (+$dialCode)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryModel &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}

// نموذج رقم الهاتف
class PhoneNumberModel {
  final String countryCode;
  final String nationalNumber;
  final String completeNumber;
  final CountryModel country;

  PhoneNumberModel({
    required this.countryCode,
    required this.nationalNumber,
    required this.completeNumber,
    required this.country,
  });
}

// Controller للـ Phone Field
class PhoneFieldController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final Rxn<CountryModel> _selectedCountry = Rxn<CountryModel>();
  final RxString _phoneNumber = ''.obs;
  final RxBool _isValid = false.obs;
  final RxBool _isInitialized = false.obs;

  CountryModel? get selectedCountry => _selectedCountry.value;
  String get phoneNumber => _phoneNumber.value;
  bool get isValid => _isValid.value;
  bool get isInitialized => _isInitialized.value;
  String get completeNumber =>
      selectedCountry != null
          ? '+${selectedCountry!.dialCode}${phoneNumber}'
          : phoneNumber;

  void setCountry(CountryModel country) {
    _selectedCountry.value = country;
    _validatePhone();
  }

  void setPhoneNumber(String number) {
    _phoneNumber.value = number;
    if (textController.text != number) {
      textController.text = number;
    }
    _validatePhone();
  }

  void initialize() {
    _isInitialized.value = true;
  }

  void _validatePhone() {
    // منطق التحقق المحسن
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    _isValid.value =
        cleanNumber.isNotEmpty &&
        cleanNumber.length >= 7 &&
        cleanNumber.length <= 15;
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}

// Widget الرئيسي
class CustomPhoneField extends StatefulWidget {
  // خصائص التصميم العامة
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;

  // خصائص النص
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final String? hintText;
  final String? labelText;
  final Color? cursorColor;
  final TextAlign textAlign;

  // خصائص الدولة
  final Widget Function(CountryModel)? countryBuilder;
  final TextStyle? countryTextStyle;
  final double? countryItemHeight;
  final Color? countryItemColor;
  final EdgeInsets? countryPadding;
  final Widget? countryDropdownIcon;
  final bool showCountryFlag;
  final bool showCountryCode;
  final bool showCountryName;

  // خصائص وظيفية
  final String? initialCountryCode;
  final String? initialPhoneNumber;
  final List<CountryModel>? countries;
  final bool enabled;
  final bool readOnly;
  final int? maxLength;
  final String? Function(String?)? validator;
  final void Function(PhoneNumberModel)? onChanged;
  final void Function(CountryModel)? onCountryChanged;
  final void Function(String)? onPhoneChanged;
  final VoidCallback? onTap;

  // خصائص الـ Dialog
  final String? dialogTitle;
  final TextStyle? dialogTitleStyle;
  final String? searchHint;
  final Color? dialogBackgroundColor;
  final double? dialogHeight;
  final EdgeInsets? dialogPadding;

  const CustomPhoneField({
    Key? key,
    // تصميم عام
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.decoration,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,

    // النص
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.hintText,
    this.labelText,
    this.cursorColor,
    this.textAlign = TextAlign.left,

    // الدولة
    this.countryBuilder,
    this.countryTextStyle,
    this.countryItemHeight,
    this.countryItemColor,
    this.countryPadding,
    this.countryDropdownIcon,
    this.showCountryFlag = true,
    this.showCountryCode = true,
    this.showCountryName = false,

    // وظيفي
    this.initialCountryCode = 'EG',
    this.initialPhoneNumber,
    this.countries,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onCountryChanged,
    this.onPhoneChanged,
    this.onTap,

    // Dialog
    this.dialogTitle,
    this.dialogTitleStyle,
    this.searchHint,
    this.dialogBackgroundColor,
    this.dialogHeight,
    this.dialogPadding,
  }) : super(key: key);

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  late PhoneFieldController controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // إنشاء controller فريد لكل widget
    final tag =
        widget.key?.toString() ??
        DateTime.now().millisecondsSinceEpoch.toString();
    controller = Get.put(PhoneFieldController(), tag: tag);

    // تهيئة القيم الافتراضية
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeController();
    });
  }

  void _initializeController() {
    if (_isInitialized) return;

    final countries = widget.countries ?? _getDefaultCountries();
    final defaultCountry = countries.firstWhere(
      (c) => c.code == widget.initialCountryCode,
      orElse: () => countries.first,
    );

    controller.setCountry(defaultCountry);

    if (widget.initialPhoneNumber != null &&
        widget.initialPhoneNumber!.isNotEmpty) {
      controller.setPhoneNumber(widget.initialPhoneNumber!);
    }

    controller.initialize();
    _isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isInitialized) {
        return Container(
          height: widget.height ?? 56,
          width: widget.width,
          margin: widget.margin,
          decoration: widget.decoration ?? _getDefaultDecoration(context),
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      }

      return Container(
        height: widget.height,
        width: widget.width,
        margin: widget.margin,
        decoration: widget.decoration ?? _getDefaultDecoration(context),
        child: Row(
          children: [
            // قسم اختيار الدولة
            _buildCountrySelector(context),

            // خط فاصل
            Container(
              height: (widget.height ?? 56) * 0.6,
              width: 1,
              color: widget.borderColor ?? Colors.grey.shade300,
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),

            // حقل إدخال الهاتف
            Expanded(child: _buildPhoneInput(context)),
          ],
        ),
      );
    });
  }

  Widget _buildCountrySelector(BuildContext context) {
    return GestureDetector(
      onTap:
          widget.enabled && !widget.readOnly
              ? () => _showCountryPicker(context)
              : null,
      child: Container(
        padding:
            widget.countryPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.countryBuilder != null)
              widget.countryBuilder!(controller.selectedCountry!)
            else
              _buildDefaultCountryItem(controller.selectedCountry!),

            const SizedBox(width: 4),
            widget.countryDropdownIcon ??
                Icon(
                  Icons.arrow_drop_down,
                  color:
                      widget.enabled
                          ? (widget.borderColor ?? Colors.grey.shade600)
                          : Colors.grey.shade400,
                  size: 20,
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultCountryItem(CountryModel country) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showCountryFlag) ...[
          Text(country.flag, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 6),
        ],
        if (widget.showCountryCode)
          Text(
            '+${country.dialCode}',
            style:
                widget.countryTextStyle ??
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: widget.enabled ? Colors.black87 : Colors.grey,
                ),
          ),
        if (widget.showCountryName) ...[
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              country.name,
              style:
                  widget.countryTextStyle ??
                  TextStyle(
                    fontSize: 14,
                    color: widget.enabled ? Colors.black87 : Colors.grey,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPhoneInput(BuildContext context) {
    return TextFormField(
      controller: controller.textController,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLength: widget.maxLength,
      textAlign: TextAlign.right, // محاذاة النص لليمين
      style:
          widget.textStyle ??
          TextStyle(
            fontSize: 16,
            color: widget.enabled ? Colors.black87 : Colors.grey,
          ),
      cursorColor: widget.cursorColor ?? Theme.of(context).primaryColor,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(widget.maxLength ?? 15),
      ],
      decoration: InputDecoration(
        hintText: widget.hintText ?? 'رقم الهاتف',

        hintStyle:
            widget.hintStyle ??
            TextStyle(color: Colors.grey.shade500, fontSize: 16),
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        contentPadding:
            widget.padding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        counterText: '',
        isDense: true,
      ),
      validator: widget.validator,
      onChanged: (value) {
        controller.setPhoneNumber(value);

        final phoneModel = PhoneNumberModel(
          countryCode: '+${controller.selectedCountry!.dialCode}',
          nationalNumber: value,
          completeNumber: '+${controller.selectedCountry!.dialCode}$value',
          country: controller.selectedCountry!,
        );

        widget.onChanged?.call(phoneModel);
        widget.onPhoneChanged?.call(value);
      },
      onTap: widget.onTap,
    );
  }

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: widget.dialogBackgroundColor ?? Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder:
          (context) => _CountryPickerDialog(
            countries: widget.countries ?? _getDefaultCountries(),
            selectedCountry: controller.selectedCountry,
            onCountrySelected: (country) {
              controller.setCountry(country);
              widget.onCountryChanged?.call(country);
              Navigator.pop(context);
            },
            title: widget.dialogTitle ?? 'Select Country',
            titleStyle: widget.dialogTitleStyle,
            searchHint: widget.searchHint ?? 'Search countries...',
            height:
                widget.dialogHeight ?? MediaQuery.of(context).size.height * 0.7,
            padding: widget.dialogPadding,
            countryItemHeight: widget.countryItemHeight ?? 60,
            countryItemColor: widget.countryItemColor,
            showFlag: widget.showCountryFlag,
            showCode: widget.showCountryCode,
            showName: true,
          ),
    );
  }

  BoxDecoration _getDefaultDecoration(BuildContext context) {
    return BoxDecoration(
      color: widget.backgroundColor ?? Colors.white,
      borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
      border: Border.all(
        color: widget.borderColor ?? Colors.grey.shade300,
        width: widget.borderWidth ?? 1,
      ),
    );
  }

  List<CountryModel> _getDefaultCountries() {
    return [
      CountryModel(name: 'Egypt', code: 'EG', dialCode: '20', flag: '🇪🇬'),
      CountryModel(
        name: 'Saudi Arabia',
        code: 'SA',
        dialCode: '966',
        flag: '🇸🇦',
      ),
      CountryModel(
        name: 'United Arab Emirates',
        code: 'AE',
        dialCode: '971',
        flag: '🇦🇪',
      ),
      CountryModel(name: 'Kuwait', code: 'KW', dialCode: '965', flag: '🇰🇼'),
      CountryModel(name: 'Qatar', code: 'QA', dialCode: '974', flag: '🇶🇦'),
      CountryModel(name: 'Bahrain', code: 'BH', dialCode: '973', flag: '🇧🇭'),
      CountryModel(name: 'Oman', code: 'OM', dialCode: '968', flag: '🇴🇲'),
      CountryModel(name: 'Jordan', code: 'JO', dialCode: '962', flag: '🇯🇴'),
      CountryModel(name: 'Lebanon', code: 'LB', dialCode: '961', flag: '🇱🇧'),
      CountryModel(name: 'Syria', code: 'SY', dialCode: '963', flag: '🇸🇾'),
      CountryModel(name: 'Iraq', code: 'IQ', dialCode: '964', flag: '🇮🇶'),
      CountryModel(
        name: 'Palestine',
        code: 'PS',
        dialCode: '970',
        flag: '🇵🇸',
      ),
      CountryModel(name: 'Morocco', code: 'MA', dialCode: '212', flag: '🇲🇦'),
      CountryModel(name: 'Algeria', code: 'DZ', dialCode: '213', flag: '🇩🇿'),
      CountryModel(name: 'Tunisia', code: 'TN', dialCode: '216', flag: '🇹🇳'),
      CountryModel(name: 'Libya', code: 'LY', dialCode: '218', flag: '🇱🇾'),
      CountryModel(name: 'Sudan', code: 'SD', dialCode: '249', flag: '🇸🇩'),
      CountryModel(
        name: 'United States',
        code: 'US',
        dialCode: '1',
        flag: '🇺🇸',
      ),
      CountryModel(
        name: 'United Kingdom',
        code: 'GB',
        dialCode: '44',
        flag: '🇬🇧',
      ),
      CountryModel(name: 'Germany', code: 'DE', dialCode: '49', flag: '🇩🇪'),
      CountryModel(name: 'France', code: 'FR', dialCode: '33', flag: '🇫🇷'),
      CountryModel(name: 'Italy', code: 'IT', dialCode: '39', flag: '🇮🇹'),
      CountryModel(name: 'Spain', code: 'ES', dialCode: '34', flag: '🇪🇸'),
      CountryModel(name: 'Turkey', code: 'TR', dialCode: '90', flag: '🇹🇷'),
    ];
  }

  @override
  void dispose() {
    // تنظيف Controller عند التخلص من Widget
    final tag = widget.key?.toString() ?? controller.hashCode.toString();
    Get.delete<PhoneFieldController>(tag: tag);
    super.dispose();
  }
}

// Dialog اختيار الدولة محسن
class _CountryPickerDialog extends StatefulWidget {
  final List<CountryModel> countries;
  final CountryModel? selectedCountry;
  final Function(CountryModel) onCountrySelected;
  final String title;
  final TextStyle? titleStyle;
  final String searchHint;
  final double height;
  final EdgeInsets? padding;
  final double countryItemHeight;
  final Color? countryItemColor;
  final bool showFlag;
  final bool showCode;
  final bool showName;

  const _CountryPickerDialog({
    required this.countries,
    required this.selectedCountry,
    required this.onCountrySelected,
    required this.title,
    this.titleStyle,
    required this.searchHint,
    required this.height,
    this.padding,
    required this.countryItemHeight,
    this.countryItemColor,
    required this.showFlag,
    required this.showCode,
    required this.showName,
  });

  @override
  State<_CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<_CountryPickerDialog> {
  final TextEditingController _searchController = TextEditingController();
  final RxList<CountryModel> _filteredCountries = <CountryModel>[].obs;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _filteredCountries.addAll(widget.countries);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _filterCountries();
    });
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      _filteredCountries.assignAll(widget.countries);
    } else {
      _filteredCountries.assignAll(
        widget.countries
            .where(
              (country) =>
                  country.name.toLowerCase().contains(query) ||
                  country.dialCode.contains(query.replaceAll('+', '')) ||
                  country.code.toLowerCase().contains(query),
            )
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: widget.padding ?? const EdgeInsets.all(16),
      child: Column(
        children: [
          // مؤشر السحب
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // العنوان
          Text(
            widget.title,
            style:
                widget.titleStyle ??
                const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 16),

          // حقل البحث
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: widget.searchHint,
                hintStyle: TextStyle(color: Colors.grey.shade500),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey.shade400),
                          onPressed: () {
                            _searchController.clear();
                            _filterCountries();
                          },
                        )
                        : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // قائمة الدول
          Expanded(
            child: Obx(() {
              if (_filteredCountries.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 48,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No countries found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                itemCount: _filteredCountries.length,
                separatorBuilder:
                    (context, index) =>
                        Divider(height: 1, color: Colors.grey.shade200),
                itemBuilder: (context, index) {
                  final country = _filteredCountries[index];
                  final isSelected =
                      widget.selectedCountry?.code == country.code;

                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => widget.onCountrySelected(country),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: widget.countryItemHeight,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.1)
                                  : widget.countryItemColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            if (widget.showFlag) ...[
                              Text(
                                country.flag,
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(width: 12),
                            ],
                            if (widget.showName)
                              Expanded(
                                child: Text(
                                  country.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                    color:
                                        isSelected
                                            ? Theme.of(context).primaryColor
                                            : Colors.black87,
                                  ),
                                ),
                              ),
                            if (widget.showCode)
                              Text(
                                '+${country.dialCode}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isSelected
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey.shade600,
                                ),
                              ),
                            if (isSelected) ...[
                              const SizedBox(width: 8),
                              Icon(
                                Icons.check_circle,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}
