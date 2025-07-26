import 'package:enter_tainer/app/views/modules/Drawer/Notification/notification_screen.dart';
import 'package:enter_tainer/app/views/modules/Drawer/favourites/favourite_screen.dart';
import 'package:flutter/material.dart' hide SizedBox;
import 'package:get/get.dart';
import 'package:neuss_utils/utils/utils.dart';

import '../../widgets/build_width_card.dart';
import '../../widgets/filter_bottom_sheet.dart';
import '../main_screen/screens/product_details.dart';
import '../stations/stations_screen.dart';

class AllOutletsScreen extends StatefulWidget {
  const AllOutletsScreen({Key? key}) : super(key: key);

  @override
  State<AllOutletsScreen> createState() => _AllOutletsScreenState();
}

class _AllOutletsScreenState extends State<AllOutletsScreen> {
  final List<String> filters = ['بالقرب مني', 'عروض جديدة', 'شهري', 'فلتر'];
  final Set<int> selectedFilters = {};
  int nearbyType = 0; // 0: الكل، 1: بالقرب مني، 2: بعيدة عني

  // بيانات تجريبية للمطاعم بنفس شكل صفحة التوصيل
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

  final List<Map<String, dynamic>> outlets = [
    {
      'title': 'الريال لاندج',
      'subtitle': 'فندق وأجنحة تايم اوك',
      'type': 'عربي',
      'image':
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400',
      'rating': 3.9,
    },
    {
      'title': 'اليوم دايفينغ',
      'subtitle': 'حميا\nأماكن التسلية والترفيه',
      'type': 'غواص',
      'image':
          'https://images.unsplash.com/photo-1464983953574-0892a716854b?w=400',
      'rating': 4.6,
    },
    {
      'title': 'التراس - ميديا روتانا',
      'subtitle': 'ميديا روتانا',
      'type': 'دورات',
      'image':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400',
      'rating': 4.2,
    },
    {
      'title': 'السياحة الصحراوية',
      'subtitle': 'القصيم\nأماكن التسلية والترفيه',
      'type': 'غواص',
      'image':
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?w=400',
      'rating': 4.0,
    },
  ];

  bool isFullWidthView = false;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'جميع المنافذ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Get.to(NotificationScreen());
                  },
                  tooltip: 'الإشعارات',
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.black),
                  onPressed: () {
                    Get.to(FavouriteScreen());
                  },
                  tooltip: 'المفضلة',
                ),
                IconButton(
                  icon: const Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                  tooltip: 'ابتسامة',
                ),
              ],
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            // شريط البحث والأزرار العلوية
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'بحث...',
                        hintStyle: const TextStyle(fontSize: 14),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  hSpace16,
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
            // الفلاتر
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: List.generate(filters.length, (index) {
                  final filter = filters[index];
                  final isSelected = selectedFilters.contains(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isSelected)
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFilters.remove(index);
                                    if (index == 0) nearbyType = 0;
                                  });
                                  applyFilters();
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                        ],
                      ),
                      selected: isSelected,
                      selectedColor: Colors.black,
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (selected) async {
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
                        } else if (index == 3) {
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
                    ),
                  );
                }),
              ),
            ),
            // SizedBox(height: 8),
            // عدد المنافذ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '549 المنفذ',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  ViewModeToggle(
                    isFullWidthView: isFullWidthView,
                    onChanged: (val) => setState(() => isFullWidthView = val),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 8),
            // قائمة المنافذ
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: filteredRestaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = filteredRestaurants[index];
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
                      Get.to(
                        () => ProductDetailsPage(
                          productName: restaurant['name']!,
                          label: '',
                        ),
                      );
                    },
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

// أضف ويدجت ViewModeToggle هنا مؤقتًا (يمكن نقلها لاحقًا لملف مشترك)
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
