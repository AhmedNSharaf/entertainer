// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/underlined_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

enum SubPage { saving, topMerchants, categories }

class _AnalyticsState extends State<Analytics> {
  bool _isSwitched = false;
  bool firstPage = true;
  SubPage currentSubPage = SubPage.saving;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'التحليلات والادخار',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPageToggle(),
            const SizedBox(height: 20),
            AnalyticsSwitchRow(
              value: _isSwitched,
              onChanged: (value) {
                setState(() => _isSwitched = value);
              },
            ),
            const SizedBox(height: 20),
            _buildSubPageSelector(),
            const SizedBox(height: 20),
            Expanded(
              child:
                  firstPage
                      ? _buildCurrentSubPage()
                      : Container(
                        width: double.infinity,
                        color: Colors.green[50],
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageToggle() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildToggleText('هذا العام', firstPage, () {
            setState(() => firstPage = true);
          }),
          const SizedBox(width: 14),
          _buildToggleText('حياة', !firstPage, () {
            setState(() => firstPage = false);
          }),
        ],
      ),
    );
  }

  Widget _buildToggleText(String label, bool isSelected, VoidCallback onTap) {
    return isSelected
        ? UnderlinedText(
          buttonText: label,
          underlineTextColor: Colors.blue[800]!,
        )
        : GestureDetector(
          onTap: onTap,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        );
  }

  Widget _buildSubPageSelector() {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildToggleText('الادخار', currentSubPage == SubPage.saving, () {
                setState(() => currentSubPage = SubPage.saving);
              }),
              _buildToggleText(
                'افضل 10 تجار',
                currentSubPage == SubPage.topMerchants,
                () {
                  setState(() => currentSubPage = SubPage.topMerchants);
                },
              ),
              _buildToggleText(
                'فئات',
                currentSubPage == SubPage.categories,
                () {
                  setState(() => currentSubPage = SubPage.categories);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentSubPage() {
    switch (currentSubPage) {
      case SubPage.saving:
        return const ThisYearAnalyticsBody();
      case SubPage.topMerchants:
        return const Placeholder();
      case SubPage.categories:
        return const Placeholder();
    }
  }
}

class AnalyticsSwitchRow extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AnalyticsSwitchRow({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnalyticsCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'استكشف تحليلات الاسرة والادخار',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Switch(
            activeColor: Colors.blue[800],
            inactiveTrackColor: Colors.grey[300],
            inactiveThumbColor: Colors.white,
            activeTrackColor: Colors.blue[200],
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class AnalyticsCard extends StatelessWidget {
  final Widget child;
  const AnalyticsCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Directionality(textDirection: TextDirection.rtl, child: child),
      ),
    );
  }
}

class ThisYearAnalyticsBody extends StatelessWidget {
  const ThisYearAnalyticsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AnalyticsCard(child: Row(children: [Text('2025 مدخرات')])),
      ],
    );
  }
}
