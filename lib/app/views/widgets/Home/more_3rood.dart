import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/main_screen/screens/details_grid_view.dart';
import '../../modules/main_screen/screens/product_details.dart' hide SizedBox;
import 'offer_card.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onIconTap;
  final IconData icon;

  const SectionHeader({
    super.key,
    required this.title,
    this.onIconTap,
    this.icon = Icons.arrow_forward_ios,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if (onIconTap != null)
              GestureDetector(
                onTap: onIconTap,
                child: Icon(icon, color: Colors.blue, size: 28),
              ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> dummyOffers = [
  {
    'imageUrl':
        'https://images.unsplash.com/photo-1560347876-aeef00ee58a1?w=400&q=60',
    'title': 'Grand Palace Hotel',
    'address': 'Dubai, UAE',
  },
  {
    'imageUrl':
        'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=400&q=60',
    'title': 'Sea View Resort',
    'address': 'Alexandria, Egypt',
  },
  {
    'imageUrl':
        'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=400&q=60',
    'title': 'Mountain Inn',
    'address': 'Zurich, Switzerland',
  },
];
final List<Map<String, String>> monthlyOffers = [
  {
    'imageUrl':
        'https://images.unsplash.com/photo-1571501679680-de32f1e7aad4?w=400&q=60',
    'title': 'Summer Breeze Resort',
    'address': 'Amman, Jordan',
  },
  {
    'imageUrl':
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&q=60',
    'title': 'Palm Grove Hotel',
    'address': 'Amman, Jordan',
  },
  {
    'imageUrl':
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&q=60',
    'title': 'Downtown Boutique Stay',
    'address': 'Amman, Jordan',
  },
  {
    'imageUrl':
        'https://images.unsplash.com/photo-1571501679680-de32f1e7aad4?w=400&q=60',
    'title': 'Skyline Hotel',
    'address': 'Amman, Jordan',
  },
];

class OffersHorizontalGrid extends StatelessWidget {
  final List<Map<String, String>> offers;

  const OffersHorizontalGrid({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return OfferCard(
            imageUrl: offer['imageUrl']!,
            title: offer['title']!,
            address: offer['address']!,
            deliveryTime: '',
            onTap: () {
              Get.to(
                () => ProductDetailsPage(
                  productName: offer['title']!,
                  label: offer['title']!,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OffersSection extends StatelessWidget {
  final String sectionTitle;
  final VoidCallback? onIconTap;
  final List<Map<String, String>>? offers;

  const OffersSection({
    super.key,
    required this.sectionTitle,
    this.offers,
    this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    // لو offers جاية من الخارج استخدمها، لو مش جاية استخدم dummyOffers
    final dataToShow = offers ?? dummyOffers;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: sectionTitle, onIconTap: onIconTap),
        OffersHorizontalGrid(offers: dataToShow),
      ],
    );
  }
}
