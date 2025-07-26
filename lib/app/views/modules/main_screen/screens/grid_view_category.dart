import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'details_grid_view.dart';

class MainGridViewCategory extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      "icon": "https://img.icons8.com/color/48/restaurant.png",
      "label": "مطاعم جاهزة",
    },
    {
      "icon": "https://img.icons8.com/color/48/food-bar.png",
      "label": "مطاعم كاجوال",
    },
    {
      "icon": "https://img.icons8.com/color/48/food.png",
      "label": "فنادق وإقامة",
    },
    {
      "icon": "https://img.icons8.com/color/48/food-truck.png",
      "label": "شاحنات طعام",
    },
    {"icon": "https://img.icons8.com/color/48/discount.png", "label": "عروض"},
    {
      "icon": "https://img.icons8.com/color/48/shopping-mall.png",
      "label": "شارع التسوق",
    },
    {
      "icon": "https://img.icons8.com/color/48/food.png",
      "label": "تجميل وعناية",
    },
    {"icon": "https://img.icons8.com/color/48/food.png", "label": "خدمات صحية"},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 14,
        crossAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Card(
              elevation: 3,
              color: Colors.white,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  final label = items[index]["label"]!;
                  Get.to(
                    () => DetailsGridView(
                      label: label,
                      subCategories: [
                        // عروض جديدة
                        {
                          "image":
                              "https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg",
                          "name": "مطعم الفلافل الشامي",
                          "location": "شارع الشيخ زايد",
                          "cuisine": "سوري · فلافل",
                          "rating": 4.3,
                          "isFeatured": true,
                          "monthlyOffer": false,
                          "delivery": true,
                          "deliveryOnly": false,
                          "distance": 7.8,
                        },
                        {
                          "image":
                              "https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg",
                          "name": "بيتزا بابا جونز",
                          "location": "ديرة",
                          "cuisine": "إيطالي · بيتزا",
                          "rating": 4.1,
                          "isFeatured": true,
                          "monthlyOffer": true,
                          "delivery": true,
                          "deliveryOnly": false,
                          "distance": 3.2,
                        },
                        {
                          "image":
                              "https://images.pexels.com/photos/1435904/pexels-photo-1435904.jpeg",
                          "name": "كباب مشوي على الفحم",
                          "location": "الخليج التجاري",
                          "cuisine": "تركي · كباب",
                          "rating": 4.5,
                          "isFeatured": true,
                          "monthlyOffer": false,
                          "delivery": true,
                          "deliveryOnly": false,
                          "distance": 4.7,
                        },

                        // الشهرية
                        {
                          "image":
                              "https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg",
                          "name": "برجر هاوس",
                          "location": "دبي مارينا",
                          "cuisine": "أمريكي · برجر",
                          "rating": 4.0,
                          "isFeatured": false,
                          "monthlyOffer": true,
                          "deliveryOnly": true,
                          "delivery": false,
                          "distance": 2.5,
                        },
                        {
                          "image":
                              "https://images.pexels.com/photos/262959/pexels-photo-262959.jpeg",
                          "name": "المطعم الهندي الملكي",
                          "location": "الكرامة",
                          "cuisine": "هندي · كاري",
                          "rating": 4.6,
                          "isFeatured": true,
                          "monthlyOffer": true,
                          "delivery": false,
                          "deliveryOnly": false,
                          "distance": 6.3,
                        },
                        {
                          "image":
                              "https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg",
                          "name": "سوشي تايم",
                          "location": "مرسى دبي",
                          "cuisine": "ياباني · سوشي",
                          "rating": 4.2,
                          "isFeatured": false,
                          "monthlyOffer": true,
                          "delivery": true,
                          "deliveryOnly": false,
                          "distance": 3.5,
                        },

                        // إضافية متنوعة
                        {
                          "image":
                              "https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg",
                          "name": "تاكو مكسيكي",
                          "location": "القصيص",
                          "cuisine": "مكسيكي · تاكو",
                          "rating": 3.9,
                          "isFeatured": false,
                          "monthlyOffer": false,
                          "delivery": true,
                          "deliveryOnly": true,
                          "distance": 5.0,
                        },
                      ],
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: NetworkImage(items[index]["icon"]!),
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          items[index]["label"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
