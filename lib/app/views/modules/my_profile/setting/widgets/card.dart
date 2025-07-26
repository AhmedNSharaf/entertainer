import 'package:flutter/material.dart';

class SwappingCard extends StatelessWidget {
  const SwappingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 160,
        color: Colors.grey[100],

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Spacer(flex: 3),
                    Text(
                      textAlign: TextAlign.center,
                      'the😊 \nENTERTAINER',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'انترتينر الخليج 2025',
                      style: TextStyle(
                        color: Colors.blue[400],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'USD 115.72',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'USD 170.19',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '(يشمل ضريبة القيمة المضافة)',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      'العضوية سارية حتى 30 ديسمبر 2025',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Spacer(flex: 1),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 170,
              height: 200,
              child: Image.network(
                fit: BoxFit.cover,
                'https://images.unsplash.com/photo-1511895426328-dc8714191300?w=400&h=200&fit=crop',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

