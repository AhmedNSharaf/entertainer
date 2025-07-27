
import 'package:enter_tainer/app/views/modules/main_screen/widgets/share_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class ShareBottomSheet extends StatelessWidget {
  final String shareUrl;
  final String shareText;

  const ShareBottomSheet({super.key, required this.shareUrl, required this.shareText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'مشاركة',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          // Social media buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ShareIconButton(
                icon: Icons.facebook,
                label: 'Facebook',
                color: const Color(0xFF1877F3),
                onTap: () => _shareToFacebook(),
              ),
              ShareIconButton(
                icon: FontAwesomeIcons.whatsapp,
                label: 'WhatsApp',
                color: const Color(0xFF25D366),
                onTap: () => _shareToWhatsApp(),
              ),
              ShareIconButton(
                icon: Icons.link,
                label: 'Copy Link',
                color: Colors.grey[700]!,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: shareUrl));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          // More options
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextButton.icon(
              onPressed: () => Share.share(shareUrl),
              icon: const Icon(Icons.share),
              label: const Text('المزيد من خيارات المشاركة'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  void _shareToFacebook() async {
    final facebookUrl = Uri.encodeFull(
      "https://www.facebook.com/sharer/sharer.php?u=$shareUrl",
    );
    if (await canLaunchUrl(Uri.parse(facebookUrl))) {
      await launchUrl(
        Uri.parse(facebookUrl),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void _shareToWhatsApp() async {
    final whatsappUrl = Uri.encodeFull("https://wa.me/?text=$shareUrl");
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(
        Uri.parse(whatsappUrl),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
