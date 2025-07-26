import 'package:flutter/material.dart';

class CallUsBottomSheet extends StatelessWidget {
  const CallUsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double sheetHeight = MediaQuery.of(context).size.height * 0.5;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: sheetHeight,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, size: 32),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'تحتاج مساعدة؟',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'تواصل مع فريق رعاية العملاء.',
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: const [
                    _ContactCard(
                      icon: Icons.email_outlined,
                      title: 'راسلنا عبر البريد الإلكتروني',
                      subtitle: 'customerservice@t...',
                      details: 'وقت الاستجابة 1-2 أيام',
                    ),
                    SizedBox(width: 8),
                    _ContactCard(
                      icon: Icons.chat_bubble_outline,
                      title: 'الدردشة الحية',
                      subtitle: '24/7',
                      details: '',
                      badge: true,
                    ),
                    SizedBox(width: 8),
                    _ContactCard(
                      icon: Icons.phone_outlined,
                      title: 'اتصل بنا',
                      subtitle: '+97144279575',
                      details: '9am-5:30pm',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Divider(height: 1, thickness: 1),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'الأسئلة الشائعة',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      'كيفية استرداد العروض',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String details;
  final bool badge;
  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.details,
    this.badge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 28, color: Colors.black87),
                if (badge)
                  Container(
                    margin: const EdgeInsets.only(right: 4, left: 4),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
            if (details.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                details,
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
