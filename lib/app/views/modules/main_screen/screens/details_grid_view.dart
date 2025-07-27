import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/utils/constants.dart';
import 'package:neuss_utils/widgets/src/txt.dart';

import '../../../widgets/build_width_card.dart';
import '../../stations/stations_screen.dart';
import 'product_details.dart';

class DetailsGridView extends StatefulWidget {
  final String label;
  final List<Map<String, dynamic>> subCategories;
  final int? categoryId; // Added for potential API calls

  const DetailsGridView({
    super.key,
    required this.subCategories,
    required this.label,
    this.categoryId,
  });

  @override
  State<DetailsGridView> createState() => _DetailsGridViewState();
}

class _DetailsGridViewState extends State<DetailsGridView> {
  final List<Map<String, dynamic>> filters = [
    {"label": "بالقرب مني", "icon": Icons.location_on},
    {"label": "عروض جديدة", "icon": Icons.local_offer},
    {"label": "شهرياً", "icon": Icons.calendar_month},
    {"label": "فلتر", "icon": Icons.filter_list},
  ];
  Set<int> selectedFilters = {};
  bool isFullWidthView = false;

  late List<Map<String, dynamic>> filteredSubCategories;
  int nearbyType = 0;

  @override
  void initState() {
    super.initState();
    filteredSubCategories = List.from(widget.subCategories);
    nearbyType = 0;
    selectedFilters.remove(0);
  }

  void applyFilters() {
    if (selectedFilters.isEmpty) {
      setState(() {
        filteredSubCategories = List.from(widget.subCategories);
      });
      return;
    }
    
    List<Map<String, dynamic>> temp = [];
    for (var item in widget.subCategories) {
      bool matches = false;
      for (var filterIndex in selectedFilters) {
        if (filterIndex == 0) {
          // بالقرب مني
          if (nearbyType == 0) {
            matches = true;
          } else if (nearbyType == 1 && item["location"] == "ديرة") {
            matches = true;
          } else if (nearbyType == 2 && item["location"] != "ديرة") {
            matches = true;
          }
        }
        if (filterIndex == 1 && item["isFeatured"] == true) {
          matches = true;
        }
        if (filterIndex == 2 && item["monthlyOffer"] == true) {
          matches = true;
        }
        if (filterIndex == 3 && item["delivery"] == true) {
          matches = true;
        }
      }
      if (matches) temp.add(item);
    }
    setState(() {
      filteredSubCategories = temp;
    });
  }

  void _performSearch(String searchTerm) {
    if (searchTerm.isEmpty) {
      setState(() {
        filteredSubCategories = List.from(widget.subCategories);
      });
      return;
    }

    setState(() {
      filteredSubCategories = widget.subCategories.where((item) {
        final name = item["name"]?.toString().toLowerCase() ?? "";
        final description = item["description"]?.toString().toLowerCase() ?? "";
        final searchLower = searchTerm.toLowerCase();
        
        return name.contains(searchLower) || description.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Txt(widget.label),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.emoji_emotions_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // Search and filters
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'اسم المطعم، المطبخ، أو الصنف...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: _performSearch,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => StationsScreen());
                      },
                      child: const Icon(Icons.map, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            vSpace8,
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filters.length,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        final filter = filters[index];
                        final isSelected = selectedFilters.contains(index);

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FilterChip(
                            selected: isSelected,
                            onSelected: (_) async {
                              if (index == 0) {
                                // Toggle nearbyType: 0 -> 1 -> 2 -> 0
                                setState(() {
                                  if (!isSelected) {
                                    selectedFilters.add(0);
                                    nearbyType = 1;
                                  } else {
                                    nearbyType = (nearbyType + 1) % 3;
                                    if (nearbyType == 0) {
                                      selectedFilters.remove(0);
                                    }
                                  }
                                });
                                applyFilters();
                              } else if (index == 3) {
                                // فلتر BottomSheet
                                // final result = await showModalBottomSheet<
                                //   Map<String, Set<String>>
                                // >(
                                //   context: context,
                                //   isScrollControlled: true,
                                //   backgroundColor: Colors.transparent,
                                //   builder: (_) => FilterBottomSheet(
                                //     options: const {
                                //       'نوع العرض': [
                                //         'خصم مباشر',
                                //         'قسيمة شراء',
                                //         'هدية مجانية',
                                //         'عرض لفترة محدودة',
                                //       ],
                                //       'نوع المطاعم': [
                                //         'إيرلندي',
                                //         'آسيوي',
                                //         'أمريكي',
                                //         'بريطاني',
                                //         'تايلاندي',
                                //         'عربي',
                                //         'كوري',
                                //         'مكسيكي',
                                //         'هندي',
                                //         'يوناني',
                                //       ],
                                //       'التسهيلات': [
                                //         'إطلالة',
                                //         'اتصال لاسلكي بشبكة الإنترنت واي فاي',
                                //         'استقبال الأولاد',
                                //         'التدخين',
                                //         'الحانات على السطح',
                                //         'تدفئة في الخارج',
                                //         'ترفيه مباشر',
                                //         'خدمة رصف السيارات',
                                //         'شيشة',
                                //         'صالح لأصحاب الهمم',
                                //         'مفتوح لوقت متأخر',
                                //         'مقاعد في الخارج',
                                //         'منتجات لحم خنزير',
                                //         'موقف سيارات',
                                //       ],
                                //     },
                                //     initialSelected: const {
                                //       'نوع العرض': {},
                                //       'نوع المطاعم': {},
                                //       'التسهيلات': {},
                                //     },
                                //     onApply: (selections) {
                                //       // يمكنك هنا ربط selections بمنطق التصفية لاحقاً
                                //     },
                                //   ),
                                // );
                              } else {
                                setState(() {
                                  if (isSelected) {
                                    selectedFilters.remove(index);
                                  } else {
                                    selectedFilters.add(index);
                                  }
                                });
                                applyFilters();
                              }
                            },
                            backgroundColor: Colors.white,
                            selectedColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  filter["icon"],
                                  size: 16,
                                  color:
                                      isSelected ? Colors.white : Colors.grey,
                                ),
                                Text(
                                  index == 0 && isSelected
                                      ? (nearbyType == 1
                                          ? "بالقرب مني"
                                          : (nearbyType == 2
                                              ? "بعيدة عني"
                                              : "كل الأماكن"))
                                      : filter["label"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                                if (isSelected) ...[
                                  GestureDetector(
                                    onTap: () {
                                      if (index == 0) {
                                        setState(() {
                                          selectedFilters.remove(index);
                                          nearbyType = 0;
                                        });
                                      } else {
                                        setState(() {
                                          selectedFilters.remove(index);
                                        });
                                      }
                                      applyFilters();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            vSpace8,
            // ViewModeToggle تحت الفلاتر
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  const Text(
                    'طريقة العرض:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ViewModeToggle(
                    isFullWidthView: isFullWidthView,
                    onChanged: (val) => setState(() => isFullWidthView = val),
                  ),
                ],
              ),
            ),
            // Show items count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  Text(
                    'عدد العناصر: ${filteredSubCategories.length}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredSubCategories.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'لا توجد نتائج',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: filteredSubCategories.length,
                      itemBuilder: (context, index) {
                        final r = filteredSubCategories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: UnifiedRestaurantCard(
                            name: r["name"]?.toString() ?? '',
                            cuisine: r["cuisine"]?.toString() ?? '',
                            location: r["location"]?.toString() ?? '',
                            rating: r["rating"]?.toString() ?? '',
                            status: r["deliveryOnly"] == true
                                ? 'توصيل فقط'
                                : (r["delivery"] == true
                                    ? 'التوصيل متاح'
                                    : 'غير متاح'),
                            imageUrl: r["image"]?.toString() ?? '',
                            isFullWidthView: isFullWidthView,
                            onTap: () {
                              Get.to(
                                () => ProductDetailsPage(
                                  productName: r["name"] ?? '',
                                  label: widget.label,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ويدجت ViewModeToggle مؤقتًا هنا
class ViewModeToggle extends StatelessWidget {
  final bool isFullWidthView;
  final ValueChanged<bool> onChanged;
  const ViewModeToggle({
    super.key,
    required this.isFullWidthView,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            isFullWidthView ? Icons.view_list : Icons.menu,
            color: isFullWidthView ? Colors.grey : Colors.blue,
          ),
          onPressed: () => onChanged(false),
        ),
        IconButton(
          icon: Icon(
            isFullWidthView ? Icons.menu_book : Icons.view_module,
            color: isFullWidthView ? Colors.blue : Colors.grey,
          ),
          onPressed: () => onChanged(true),
        ),
      ],
    );
  }
}