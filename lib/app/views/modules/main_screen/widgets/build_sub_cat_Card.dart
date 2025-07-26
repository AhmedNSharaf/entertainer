import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/product_details.dart';

class BuildSubCategoryCard extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final String cuisine;
  final double rating;
  final bool isFeatured;
  final bool delivery;
  final bool deliveryOnly;

  const BuildSubCategoryCard({
    super.key,
    required this.image,
    required this.name,
    required this.location,
    required this.cuisine,
    required this.rating,
    this.isFeatured = false,
    this.delivery = false,
    this.deliveryOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ListTile(
        onTap: () {
          Get.to(() => ProductDetailsPage(label: name, productName: ''));
        },
        leading: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            if (isFeatured)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'مميز',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textDirection: TextDirection.rtl,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location,
              style: const TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
            ),
            Text(
              cuisine,
              style: const TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
            ),
            Row(
              children: [
                const Text('الآراء:', style: TextStyle(fontSize: 14)),
                // const SizedBox(width: 4),
                Text(
                  rating.toString(),
                  style: const TextStyle(color: Colors.amber, fontSize: 14),
                ),
                const Icon(Icons.star, color: Colors.amber, size: 16),
              ],
            ),
          ],
        ),
        trailing:
            deliveryOnly
                ? const Text('توصيل فقط', style: TextStyle(color: Colors.grey))
                : delivery
                ? const Text('التوصيل', style: TextStyle(color: Colors.grey))
                : null,
      ),
    );
  }
}
