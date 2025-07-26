import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../buy_offer_bottom_sheet.dart';

class ProductCupon extends StatefulWidget {
  const ProductCupon({super.key});

  @override
  State<ProductCupon> createState() => _ProductCuponState();
}

class _ProductCuponState extends State<ProductCupon> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),

      child: Column(
        children: [
          // Header مع دبي والسهم
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Dubai 2025",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 28,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ],
            ),
          ),

          // البطاقات
          if (isExpanded)
            Column(children: List.generate(3, (_) => buildOfferCard())),
        ],
      ),
    );
  }

  Widget buildOfferCard() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () async {
          // تشغيل الفايبريشن
          // if (await Vibration.hasVibrator() ?? false) {
          //   Vibration.vibrate(duration: 100);
          // }
          // فتح البوتوم شيت بتصميم مخصص
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const BuyOfferBottomSheet(),
          );
        },
        child: Container(
          height: Get.height * 0.12,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.redAccent),
            color: Colors.grey.withOpacity(.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Red Section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Center(
                    child: Text(
                      "BUY 1\n GET 1\n FREE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // نصوص بجانب الأحمر
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "طبق رئيسي",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      "صالح لغذاء وعشاء",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      "شروط",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                // باقي العناصر (القفل وزر الشراء)
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.lock, color: Colors.white, size: 28),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.1),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Text(
                            "ENTERTAINER 2025",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _productCard({
    required String imageUrl, // <-- صورة من الإنترنت
    required String title,
    required String desc,
    required String oldPrice,
    required String save,
    required String price,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
        ),
        height: Get.height * 0.25,
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$ $oldPrice',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '\$ $price',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'توفير \$ $save',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            // النصوص والزر على اليمين
          ],
        ),
      ),
    );
  }
}
