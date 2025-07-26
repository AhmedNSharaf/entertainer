import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/product_card.dart';
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/underlined_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'countries_bottom_sheet.dart';

class ProductBottomSheet extends StatelessWidget {
  const ProductBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'اختر منتجا',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const Text(
                    'الذي يناسب أسلوبك',
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  ),
                ],
              ),
            ),

            // Product Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ProductCard(
                    title: 'إنترنتر ديب 2025',
                    subtitle: 'تومير يومي على كل ما تحب',
                    originalPrice: '170.18 USD',
                    currentPrice: '115.72',
                    discount: 'USD 54.46',
                    validUntil: '30 ديسمبر 2025',
                    gradientColors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                    productType: 'ديب\n2025',
                  ),
                  const SizedBox(height: 16),
                  ProductCard(
                    title: 'إنترنتر الخليج 2025',
                    subtitle: 'مناسب لمحبي التنقل والتوفر عبر المنطقة',
                    originalPrice: '216.47 USD',
                    currentPrice: '134.79',
                    discount: 'USD 81.68',
                    validUntil: '30 ديسمبر 2025',
                    gradientColors: [Color(0xFFB8860B), Color(0xFF996515)],
                    productType: 'الخليج\n2025',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Or divider
            // Or divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Expanded(
                    child: Divider(color: Colors.grey, thickness: 1),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'أو',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: Colors.grey, thickness: 1),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Bottom button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                ),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const LocationBottomSheet(),
                    );
                  },
                  child: const Text(
                    'اكتشف المنتجات في مناطق أخرى',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Travel now button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  Get.back(); // Close the bottom sheet
                },
                child: UnderlinedText(
                  buttonText: 'سأقرر لاحقا',
                  underlineTextColor: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
