import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/underlined_text.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String originalPrice;
  final String currentPrice;
  final String discount;
  final String validUntil;
  final List<Color> gradientColors;
  final String productType;

  const ProductCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.originalPrice,
    required this.currentPrice,
    required this.discount,
    required this.validUntil,
    required this.gradientColors,
    required this.productType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 80,
              height: 140,

              child: Image.network(
                'https://images.unsplash.com/photo-1511895426328-dc8714191300?w=400&h=200&fit=crop',
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
                const SizedBox(height: 8),

                // Learn More Button
                Align(
                  alignment: Alignment.centerRight,
                  child: UnderlinedText(
                    buttonText: 'يتعلم أكثر',
                    underlineTextColor: Colors.blue[800]!,
                  ),
                ),

                const SizedBox(height: 8),

                // Discount Badge
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'يحفظ $discount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Original Price (crossed out)
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    originalPrice,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                // Current Price
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: currentPrice,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const TextSpan(
                          text: 'USD',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                // Additional Info
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '(شمول ضريبة القيمة المضافة)',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'العضوية سارية حتى $validUntil',
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
