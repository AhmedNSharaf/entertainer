import 'package:flutter/material.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({super.key});

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  final List<String> offers = [
    'طعام مماثل',
    'تناول طعام غير رسمي',
    'الوجبات السريعة',
    'توصيل الطعام',
    'وجبات الإفطار والغداء',
    'هاتف (المشروبات)',
    'المتاجر الرقمية',
    'أنشطة الأطفال',
    'اليوغا',
    'الرياضة واللياقة',
    'المنتجات الصحية',
    'جاذبية',
    'صالونات السيدات',
    'العناية بالأظافر',
    'لياقة بدنية',
    'خدمات منزلية',
    'بيع المجوهرات',
    'المنتجعات الصحية',
    'المنتجعات الفندقية',
    'التنظيف والغسيل',
    'الإقامات الفندقية',
    'رعاية الحيوانات الأليفة والعناية بها',
  ];
  final List<String> familyTypes = ['منفرد', 'زوج', 'عائلة'];
  final List<String> genders = ['أنثى', 'ذكر', 'أفضل ألا أقول'];
  final List<String> nationalities = [
    'مصري',
    'سعودي',
    'أردني',
    'إماراتي',
    'سوري',
    'أخرى',
  ];

  Set<String> selectedOffers = {};
  int selectedFamily = 0;
  int selectedGender = 0;
  int? selectedNationality;
  DateTime? birthDate;

  @override
  Widget build(BuildContext context) {
    const mainBlue = Color(0xff204cf5);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.grey[100],
                    child: Icon(
                      Icons.person,
                      size: 56,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Omar Ragab',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'يرجى مشاركة القليل عن نفسك لتحقيق أقصى استفادة من تطبيق ENTERTAINER الخاص بك',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'سياسة الخصوصية',
                    style: TextStyle(
                      color: mainBlue,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: const [
                      Text(
                        'ما هي العروض التي تهمك أكثر؟',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'حدد كل ما ينطبق',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        offers.map((offer) {
                          final selected = selectedOffers.contains(offer);
                          return ChoiceChip(
                            label: Text(
                              offer,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selected ? Colors.white : Colors.black,
                              ),
                            ),
                            selected: selected,
                            selectedColor: mainBlue,
                            backgroundColor: Colors.grey[50],
                            onSelected: (val) {
                              setState(() {
                                if (selected) {
                                  selectedOffers.remove(offer);
                                } else {
                                  selectedOffers.add(offer);
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: selected ? mainBlue : Colors.grey[300]!,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 24),
                  // كيف تضمّن أسرتك؟
                  Row(
                    children: [
                      const Text(
                        'كيف تضمّن أسرتك؟',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.help_outline,
                        size: 18,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(familyTypes.length, (i) {
                      final selected = selectedFamily == i;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedFamily = i),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              color: selected ? mainBlue : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: selected ? mainBlue : Colors.grey[300]!,
                              ),
                              boxShadow:
                                  selected
                                      ? [
                                        BoxShadow(
                                          color: mainBlue.withOpacity(0.08),
                                          blurRadius: 4,
                                        ),
                                      ]
                                      : [],
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  i == 0
                                      ? Icons.person_outline
                                      : i == 1
                                      ? Icons.people_outline
                                      : Icons.groups,
                                  color:
                                      selected ? Colors.white : Colors.black54,
                                  size: 32,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  familyTypes[i],
                                  style: TextStyle(
                                    color:
                                        selected
                                            ? Colors.white
                                            : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  // أخبرنا عن نفسك
                  Row(
                    children: const [
                      Text(
                        'أخبرنا عن نفسك',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // الجنس
                  Row(
                    children: const [
                      Text('ما هو جنسك؟', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: List.generate(genders.length, (i) {
                      final selected = selectedGender == i;
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: Material(
                          color:
                              selected
                                  ? mainBlue.withOpacity(0.08)
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () => setState(() => selectedGender = i),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: Text(
                                genders[i],
                                style: TextStyle(
                                  color: selected ? mainBlue : Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 18),
                  // الجنسية
                  Row(
                    children: const [
                      Text('ما هي جنسيتك؟', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: List.generate(nationalities.length, (i) {
                      return RadioListTile<int>(
                        value: i,
                        groupValue: selectedNationality,
                        onChanged:
                            (val) => setState(() => selectedNationality = val),
                        title: Text(nationalities[i]),
                        activeColor: mainBlue,
                        contentPadding: EdgeInsets.zero,
                      );
                    }),
                  ),
                  const SizedBox(height: 18),
                  // تاريخ الميلاد
                  Row(
                    children: const [
                      Text(
                        'متى يصادف عيد ميلادك؟',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: birthDate ?? DateTime(2000, 1, 1),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => birthDate = picked);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        birthDate == null
                            ? 'تاريخ الميلاد'
                            : '${birthDate!.year}/${birthDate!.month}/${birthDate!.day}',
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // زر تحديث
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'تحديث',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
