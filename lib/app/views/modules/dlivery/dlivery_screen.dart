import 'package:enter_tainer/app/views/modules/dlivery/returant_details_dlivery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/build_width_card.dart';
import '../../widgets/filter_bottom_sheet.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  bool isFullWidthView = false;

  final List<String> filters = [
    'بالأحدث',
    'عروض جديدة',
    'أعلى التقييمات',
    'المعايير',
    'فلتر',
  ];
  final Set<int> selectedFilters = {};
  int nearbyType = 0; // 0: الكل، 1: بالقرب مني، 2: بعيدة عني

  final List<Map<String, dynamic>> restaurants = [
    {
      'name': 'بيترا بابا جوز',
      'cuisine': 'إيطالي - بيتزا درة',
      'location': 'ديرة',
      'rating': '4.1 ★',
      'status': 'Outlet is closed 💤️',
      'isFeatured': true,
      'deliveryOnly': false,
      'delivery': true,
    },
    {
      'name': 'جاميكا بني',
      'cuisine': 'مشاوي - وجبات سريعة',
      'location': 'Al Ghurair Centre',
      'rating': '4.3 ★',
      'status': 'تنيم مباشر',
      'isFeatured': false,
      'deliveryOnly': true,
      'delivery': false,
    },
    {
      'name': 'بينزا مابستره',
      'cuisine': 'إيطالي',
      'location': 'الخريجستان',
      'rating': '4.5 ★',
      'status': 'التوصيل',
      'isFeatured': true,
      'deliveryOnly': false,
      'delivery': true,
    },
  ];

  late List<Map<String, dynamic>> filteredRestaurants;

  @override
  void initState() {
    super.initState();
    filteredRestaurants = List.from(restaurants);
    nearbyType = 0;
    selectedFilters.remove(0);
  }

  void applyFilters() {
    if (selectedFilters.isEmpty) {
      setState(() {
        filteredRestaurants = List.from(restaurants);
      });
      return;
    }
    List<Map<String, dynamic>> temp = [];
    for (var item in restaurants) {
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
        if (filterIndex == 2 && item["deliveryOnly"] == true) {
          matches = true;
        }
        if (filterIndex == 3 && item["delivery"] == true) {
          matches = true;
        }
      }
      if (matches) temp.add(item);
    }
    setState(() {
      filteredRestaurants = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomHeaderDelegate(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filters.length,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemBuilder: (context, index) {
                          final isSelected = selectedFilters.contains(index);
                          final label = filters[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FilterChip(
                              selected: isSelected,
                              onSelected: (_) async {
                                if (index == 0) {
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
                                } else if (index == 4) {
                                  // فلتر BottomSheet
                                  final result = await showModalBottomSheet<
                                    Map<String, Set<String>>
                                  >(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder:
                                        (_) => FilterBottomSheet(
                                          options: const {
                                            'نوع العرض': [
                                              'خصم مباشر',
                                              'قسيمة شراء',
                                              'هدية مجانية',
                                              'عرض لفترة محدودة',
                                            ],
                                            'نوع المطاعم': [
                                              'إيرلندي',
                                              'آسيوي',
                                              'أمريكي',
                                              'بريطاني',
                                              'تايلاندي',
                                              'عربي',
                                              'كوري',
                                              'مكسيكي',
                                              'هندي',
                                              'يوناني',
                                            ],
                                            'التسهيلات': [
                                              'إطلالة',
                                              'اتصال لاسلكي بشبكة الإنترنت واي فاي',
                                              'استقبال الأولاد',
                                              'التدخين',
                                              'الحانات على السطح',
                                              'تدفئة في الخارج',
                                              'ترفيه مباشر',
                                              'خدمة رصف السيارات',
                                              'شيشة',
                                              'صالح لأصحاب الهمم',
                                              'مفتوح لوقت متأخر',
                                              'مقاعد في الخارج',
                                              'منتجات لحم خنزير',
                                              'موقف سيارات',
                                            ],
                                          },
                                          initialSelected: const {
                                            'نوع العرض': {},
                                            'نوع المطاعم': {},
                                            'التسهيلات': {},
                                          },
                                          onApply: (selections) {
                                            // يمكنك هنا ربط selections بمنطق التصفية لاحقاً
                                          },
                                        ),
                                  );
                                  // يمكنك هنا التعامل مع النتيجة result إذا أردت
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
                                children: [
                                  Text(
                                    label,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedFilters.remove(index);
                                          if (index == 0) nearbyType = 0;
                                        });
                                        applyFilters();
                                      },
                                      child: const Icon(
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
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildRestaurantItem(context, index),
                childCount: filteredRestaurants.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Text(
          '39 المطاعم',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        ViewModeToggle(
          isFullWidthView: isFullWidthView,
          onChanged: (val) => setState(() => isFullWidthView = val),
        ),
      ],
    );
  }

  Widget _buildRestaurantItem(BuildContext context, int index) {
    final restaurant = filteredRestaurants[index % filteredRestaurants.length];

    return UnifiedRestaurantCard(
      name: restaurant['name']!,
      cuisine: restaurant['cuisine']!,
      location: restaurant['location']!,
      rating: restaurant['rating']!,
      status: restaurant['status']!,
      imageUrl:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/27/d5/bb/74/lounge.jpg?w=200&h=200&s=1',
      isFullWidthView: isFullWidthView,
      onTap: () {
        Get.to(() => RestaurantDetailsScreen(title: restaurant['name']!));
      },
    );
  }
}

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

class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight = 250;
  final double collapsedHeight = 100;

  @override
  double get minExtent => collapsedHeight;
  @override
  double get maxExtent => expandedHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double percent = 1 - (shrinkOffset / (maxExtent - minExtent));
    percent = percent.clamp(0.0, 1.0);
    final bool isCollapsed = percent <= 0.2;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/27/d5/bb/74/lounge.jpg?w=900&h=500&s=1',
          fit: BoxFit.cover,
        ),
        Container(color: Colors.black.withOpacity(0.3)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'التوصيل إلى',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'الأردن، إربد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        isCollapsed
                            ? const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 30,
                              key: ValueKey(1),
                            )
                            : const SizedBox(key: ValueKey(2)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: percent,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'هل تشعر بالجوع؟',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'وفر والي بعده التكست فورم',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 20,
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              hintText: 'اسم المعلم أو نوع الأكل أو الطبق...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
