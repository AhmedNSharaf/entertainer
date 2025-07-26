import 'package:flutter/material.dart';

class AnalysisSaveScreen extends StatefulWidget {
  const AnalysisSaveScreen({super.key});

  @override
  State<AnalysisSaveScreen> createState() => _AnalysisSaveScreenState();
}

class _AnalysisSaveScreenState extends State<AnalysisSaveScreen> {
  int mainTab = 0; // 0: هذا العام, 1: حياة
  int subTab = 0; // 0: الادخار, 1: أفضل 10 تجار, 2: فئات
  bool familySwitch = false;

  @override
  Widget build(BuildContext context) {
    const mainBlue = Color(0xff204cf5);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: mainBlue,
                pinned: true,
                floating: false,
                automaticallyImplyLeading: false,
                expandedHeight: 60,
                collapsedHeight: 60,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(bottom: 12),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 32),
                      const Text(
                        'التحليلات والادخار',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: const [
                          Text(
                            'عودة',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTab(
                            text: 'هذا العام',
                            index: 0,
                            color: mainBlue,
                          ),
                          const SizedBox(width: 24),
                          _buildTab(text: 'حياة', index: 1, color: mainBlue),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Switch(
                              value: familySwitch,
                              onChanged:
                                  (val) => setState(() => familySwitch = val),
                              activeColor: mainBlue,
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'استكشف تحليلات الأسرة والادخار',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
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
              SliverPersistentHeader(
                pinned: true,
                delegate: _AnimatedHeaderDelegate(
                  minHeight: 56,
                  maxHeight: 56,
                  builder: (context, shrinkOffset) {
                    final pad = (shrinkOffset > 0) ? 16.0 : 0.0;
                    return Container(
                      color: const Color(0xffeaf1fa),
                      padding: EdgeInsets.only(top: pad),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _SubTab(
                            'الادخار',
                            0,
                            subTab,
                            () => setState(() => subTab = 0),
                            mainBlue,
                          ),
                          _SubTab(
                            'أفضل 10 تجار',
                            1,
                            subTab,
                            () => setState(() => subTab = 1),
                            mainBlue,
                          ),
                          _SubTab(
                            'فئات',
                            2,
                            subTab,
                            () => setState(() => subTab = 2),
                            mainBlue,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  if (subTab == 0) ...[
                    const SizedBox(height: 16),
                    _InfoCard(
                      title: 'مدخرات 2025',
                      value: 'USD 0',
                      valueColor: mainBlue,
                    ),
                    _InfoCard(
                      title: 'تم الحفظ في يوليو',
                      value: 'USD 0',
                      valueColor: mainBlue,
                    ),
                    _InfoCard(
                      title: 'الابتسامات',
                      value: '0',
                      valueColor: Colors.orange,
                      icon: Icons.emoji_emotions_outlined,
                    ),
                  ] else if (subTab == 1) ...[
                    const SizedBox(height: 48),
                    Center(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.grey,
                            size: 120,
                          ),
                          SizedBox(height: 24),
                          Text(
                            'لا يوجد عمليات استرداد حتى الآن',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'لا تفوت عروضنا الحصرية – ابدأ في استرداد قيمتها اليوم!',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else if (subTab == 2) ...[
                    const SizedBox(height: 48),
                    Center(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.grey,
                            size: 120,
                          ),
                          SizedBox(height: 24),
                          Text(
                            'صفر وفورات في جميع المجالات',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'ابدأ في إجراء عمليات الاسترداد لرؤية التحليلات والمدخرات',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 80),
                ]),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'شراء منتج 2025',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab({
    required String text,
    required int index,
    required Color color,
  }) {
    final isSelected = mainTab == index;
    return GestureDetector(
      onTap: () => setState(() => mainTab = index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? color : Colors.black54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 17,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 2),
              height: 3,
              width: 50,
              color: color,
            ),
        ],
      ),
    );
  }
}

class _AnimatedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget Function(BuildContext, double) builder;
  _AnimatedHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.builder,
  });

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return builder(context, shrinkOffset);
  }

  @override
  bool shouldRebuild(_AnimatedHeaderDelegate oldDelegate) =>
      maxHeight != oldDelegate.maxHeight ||
      minHeight != oldDelegate.minHeight ||
      builder != oldDelegate.builder;
}

class _SubTab extends StatelessWidget {
  final String label;
  final int index;
  final int selected;
  final VoidCallback onTap;
  final Color mainBlue;
  const _SubTab(
    this.label,
    this.index,
    this.selected,
    this.onTap,
    this.mainBlue, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final isActive = index == selected;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? mainBlue : Colors.black54,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 2),
                height: 3,
                width: 40,
                color: mainBlue,
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;
  final IconData? icon;
  const _InfoCard({
    required this.title,
    required this.value,
    required this.valueColor,
    this.icon,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: valueColor, size: 28),
            const SizedBox(width: 8),
          ],
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
