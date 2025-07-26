import 'package:flutter/material.dart';

import 'card.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: PageView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SwappingCard(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SwappingCard(),
          ),
        ],
      ),
    );
  }
}
