import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({Key? key}) : super(key: key);

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  bool isEditing = false;

  String name = 'Omar';
  String surname = 'Ragab';
  String email = 'omarragab712000@gmail.com';
  DateTime? birthDate;
  String? nationality;
  String? residenceCountry;
  String? gender;
  String? phone;
  String? currency = 'USD';

  final List<String> nationalities = [
    'أردني',
    'مصري',
    'سعودي',
    'سوري',
    'عراقي',
    'لبناني',
    'فلسطيني',
    'مغربي',
    'جزائري',
    'تونسي',
    'آيسلندي',
    'أذربيجاني',
    'أرميني',
    'أوروبي',
    'أسترالي',
    'أفغاني',
    'ألباني',
  ];
  final List<String> countries = [
    'الأردن',
    'مصر',
    'السعودية',
    'سوريا',
    'العراق',
    'لبنان',
    'فلسطين',
    'المغرب',
    'الجزائر',
    'تونس',
  ];
  final List<String> genders = ['الذكر', 'أنثى'];
  final List<String> currencies = [
    'USD',
    'LBP',
    'MYR',
    'OMR',
    'QAR',
    'SAR',
    'SGD',
  ];

  void _pickBirthDate() async {
    picker.DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime.now(),
      currentTime: birthDate ?? DateTime(2000, 1, 1),
      locale: picker.LocaleType.ar,
      onConfirm: (date) {
        setState(() {
          birthDate = date;
        });
      },
    );
  }

  void _pickFromList({
    required List<String> items,
    required String title,
    required String? selected,
    required Function(String) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 48),
                    Expanded(
                      child: Center(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        'تم',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder:
                      (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item),
                      trailing:
                          selected == item
                              ? const Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                              )
                              : null,
                      onTap: () {
                        onSelected(item);
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

  void _showPhoneEditSheet() {
    if (!isEditing) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('اضغط أولًا على زر تعديل لتحديث البيانات'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    TextEditingController controller = TextEditingController(text: phone ?? '');
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 18,
            right: 18,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'رقم الهاتف المتحرك',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'أدخل رقم الهاتف',
                ),
                maxLength: 15,
                autofocus: true,
                onChanged: (val) {
                  setState(() {
                    phone = val;
                  });
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff204cf5),
          centerTitle: true,
          title: const Text(
            'نبذة عني',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey[100],
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 18),
                            const CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              email,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEditing = !isEditing;
                                    });
                                  },
                                  child: Text(
                                    isEditing ? 'تم' : 'تعديل',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      _AboutMeField(
                        label: 'الاسم',
                        value: name,
                        enabled: isEditing,
                      ),
                      _AboutMeField(
                        label: 'الشهرة',
                        value: surname,
                        enabled: isEditing,
                      ),
                      _AboutMeField(
                        label: 'العنوان الإلكتروني',
                        value: email,
                        enabled: isEditing,
                      ),
                      _AboutMeField(
                        label: 'تاريخ الميلاد',
                        value:
                            birthDate == null
                                ? ''
                                : '${birthDate!.day.toString().padLeft(2, '0')}/${birthDate!.month.toString().padLeft(2, '0')}/${birthDate!.year}',
                        onTap: _pickBirthDate,
                        enabled: isEditing,
                      ),
                      _AboutMeField(
                        label: 'الجنسية',
                        value: nationality ?? '',
                        onTap:
                            () => _pickFromList(
                              items: nationalities,
                              title: 'الجنسية',
                              selected: nationality,
                              onSelected:
                                  (val) => setState(() => nationality = val),
                            ),
                        enabled: isEditing,
                      ),
                      Container(
                        color: Colors.grey.withOpacity(.2),
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      _AboutMeField(
                        label: 'بلد الإقامة',
                        value: residenceCountry ?? '',
                        onTap:
                            () => _pickFromList(
                              items: countries,
                              title: 'بلد الإقامة',
                              selected: residenceCountry,
                              onSelected:
                                  (val) =>
                                      setState(() => residenceCountry = val),
                            ),
                        enabled: isEditing,
                      ),
                      _AboutMeField(
                        label: 'الجنس',
                        value: gender ?? '',
                        onTap:
                            () => _pickFromList(
                              items: genders,
                              title: 'الجنس',
                              selected: gender,
                              onSelected: (val) => setState(() => gender = val),
                            ),
                        enabled: isEditing,
                      ),
                      _AboutMeField(
                        label: 'رقم الهاتف المتحرك',
                        value: phone ?? '',
                        onTap: _showPhoneEditSheet,
                        enabled: isEditing,
                      ),
                      _AboutMeField(
                        label: 'العملة المفضلة',
                        value: currency ?? '',
                        onTap:
                            () => _pickFromList(
                              items: currencies,
                              title: 'العملة المفضلة',
                              selected: currency,
                              onSelected:
                                  (val) => setState(() => currency = val),
                            ),
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        color: Colors.grey.withOpacity(.2),
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      GestureDetector(
                        onTap: _showDeleteBottomSheet,
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Center(
                            child: Text(
                              'حذف الحساب',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.grey.withOpacity(.2),
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'حذف الحساب؟',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 12),
                const Text(
                  'سيتم حذف حسابك نهائيًا في غضون 60 يومًا. سيتم أيضًا حذف عروضك وعمليات الاسترداد والمكافآت والعضوية.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Divider(height: 1),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('العودة', style: TextStyle(fontSize: 18)),
                  ),
                ),
                Divider(height: 1),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () {
                      // تنفيذ حذف الحساب هنا
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'حذف الحساب',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Divider(height: 1),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AboutMeField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onTap;
  final bool enabled;

  const _AboutMeField({
    required this.label,
    required this.value,
    this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          enabled
              ? onTap
              : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'اضغط أولًا على زر تعديل لتحديث البيانات',
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.only(bottom: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
