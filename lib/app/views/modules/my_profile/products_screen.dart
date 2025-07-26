import 'package:flutter/material.dart';

import '../../widgets/buy_offer_bottom_sheet.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const mainBlue = Color(0xff204cf5);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: mainBlue,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leadingWidth: 120, // ✅ زودنا المساحة لتناسب المحتوى
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).maybePop();
            },
            child: Container(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      'إعدادات',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          title: const Text(
            'منتجات',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // الشكل في منتصف الشاشة
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 220,
                    height: 180,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // مربعات شفافة
                        Positioned(
                          left: 10,
                          top: 80,
                          child: _DashedBox(
                            size: 40,
                            color: Colors.grey[300]!,
                            xColor: Colors.transparent,
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 100,
                          child: _DashedBox(
                            size: 30,
                            color: Colors.grey[300]!,
                            xColor: Colors.transparent,
                          ),
                        ),
                        Positioned(
                          left: 60,
                          top: 120,
                          child: _DashedBox(
                            size: 30,
                            color: Colors.grey[300]!,
                            xColor: Colors.transparent,
                          ),
                        ),
                        // مربعات رئيسية
                        Positioned(
                          left: 0,
                          top: 40,
                          child: _DashedBox(
                            size: 70,
                            color: Colors.red,
                            xColor: Colors.red,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: _DashedBox(
                            size: 80,
                            color: Colors.red,
                            xColor: Colors.red,
                          ),
                        ),
                        Positioned(
                          right: 30,
                          bottom: 0,
                          child: _DashedBox(
                            size: 70,
                            color: Colors.red,
                            xColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // النصوص قريبة من الزر
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    const Text(
                      'يبدو أنك لا تملك منتجًا من إنترتينر بعد',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'ابدأ التوفير اليوم مع الآلاف من عروض 2 بسعر 1 وغيرها على الأكل والترفيه والصالونات والسبا وغيرها.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // زر أزرق
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const BuyOfferBottomSheet(),
                      );
                    },
                    child: const Text(
                      'إلقاء نظرة',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBox extends StatelessWidget {
  final double size;
  final Color color;
  final Color xColor;
  const _DashedBox({
    required this.size,
    required this.color,
    required this.xColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child:
            xColor == Colors.transparent
                ? null
                : Icon(Icons.close, color: xColor, size: size * 0.4),
      ),
    );
  }
}
