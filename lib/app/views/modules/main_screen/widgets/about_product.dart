import 'package:enter_tainer/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

// Constants
class AppConstants {
  static const String defaultPhoneNumber = '01018027405';
  static const double defaultBorderRadius = 12.0;
  static const double cardBorderRadius = 20.0;
  static const double iconSize = 16.0;
  static const double largePadding = 24.0;
  static const double mediumPadding = 16.0;
  static const double smallPadding = 8.0;
  static const Duration snackbarDuration = Duration(seconds: 2);
  static const Duration animationDuration = Duration(milliseconds: 300);
}

// Theme Colors
class AppTheme {
  static const Color primaryColor = Color(0xff204cf5);
  static const Color secondaryColor = Color(0xffF8FAFF);
  static const Color backgroundColor = Color(0xffF5F7FA);
  static const Color cardColor = Colors.white;
  static const Color successColor = Color(0xff10B981);
  static const Color warningColor = Color(0xffF59E0B);
  static const Color errorColor = Color(0xffEF4444);
  static const Color textPrimary = Color(0xff1F2937);
  static const Color textSecondary = Color(0xff6B7280);
  static const Color borderColor = Color(0xffE5E7EB);

  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> lightShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];
}

// Error Handler Service
class ErrorHandler {
  static void handleError(String message, {Exception? exception}) {
    debugPrint('Error: $message');
    if (exception != null) {
      debugPrint('Exception: $exception');
    }
  }

  static void showErrorSnackbar(String message) {
    Get.snackbar(
      'خطأ',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppTheme.errorColor,
      colorText: Colors.white,
      duration: AppConstants.snackbarDuration,
      borderRadius: AppConstants.defaultBorderRadius,
      margin: const EdgeInsets.all(AppConstants.mediumPadding),
    );
  }
}

// URL Launcher Service
class UrlLauncherService {
  static Future<bool> makePhoneCall(
    String phoneNumber,
    BuildContext context,
  ) async {
    if (!context.mounted) return false;

    try {
      final uri = Uri.parse('tel:$phoneNumber');
      if (await canLaunchUrl(uri)) {
        if (!context.mounted) return false;
        await launchUrl(uri);
        return true;
      }
      return false;
    } catch (e) {
      ErrorHandler.handleError(
        'Failed to make phone call',
        exception: e as Exception?,
      );
      if (context.mounted) {
        ErrorHandler.showErrorSnackbar('فشل في إجراء المكالمة');
      }
      return false;
    }
  }

  static Future<bool> sendEmail(String email, BuildContext context) async {
    if (!context.mounted) return false;

    try {
      final uri = Uri.parse('mailto:$email');
      if (await canLaunchUrl(uri)) {
        if (!context.mounted) return false;
        await launchUrl(uri);
        return true;
      }
      return false;
    } catch (e) {
      ErrorHandler.handleError(
        'Failed to send email',
        exception: e as Exception?,
      );
      if (context.mounted) {
        ErrorHandler.showErrorSnackbar('فشل في إرسال البريد الإلكتروني');
      }
      return false;
    }
  }

  static Future<bool> openGoogleMaps(String query, BuildContext context) async {
    if (!context.mounted) return false;

    try {
      final url = 'https://maps.google.com/?q=${Uri.encodeComponent(query)}';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        if (!context.mounted) return false;
        await launchUrl(uri);
        return true;
      }
      return false;
    } catch (e) {
      ErrorHandler.handleError(
        'Failed to open Google Maps',
        exception: e as Exception?,
      );
      if (context.mounted) {
        ErrorHandler.showErrorSnackbar('فشل في فتح الخريطة');
      }
      return false;
    }
  }
}

// Clipboard Service
class ClipboardService {
  static void copyToClipboard(String text) {
    try {
      Clipboard.setData(ClipboardData(text: text));
      Get.snackbar(
        'تم النسخ',
        'تم نسخ النص إلى الحافظة',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppTheme.successColor,
        colorText: Colors.white,
        duration: AppConstants.snackbarDuration,
        borderRadius: AppConstants.defaultBorderRadius,
        margin: const EdgeInsets.all(AppConstants.mediumPadding),
        boxShadows: [
          BoxShadow(
            color: AppTheme.successColor.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      );
    } catch (e) {
      ErrorHandler.handleError(
        'Failed to copy to clipboard',
        exception: e as Exception?,
      );
      ErrorHandler.showErrorSnackbar('فشل في نسخ النص');
    }
  }
}

class AboutProduct extends StatelessWidget {
  final String name;
  final String? cuisine;
  final String? location;
  final String? rating;
  final String? phone;
  final String? email;
  final String? address;
  final String? status;
  final String? category;
  final List<String>? services;
  final List<String>? features;
  final Map<String, String>? workingHours;
  final String? imageUrl;

  const AboutProduct({
    super.key,
    required this.name,
    this.cuisine,
    this.location,
    this.rating,
    this.phone,
    this.email,
    this.address,
    this.status,
    this.category,
    this.services,
    this.features,
    this.workingHours,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          _CustomSliverAppBar(),
          SliverToBoxAdapter(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  const SizedBox(height: AppConstants.mediumPadding),
                  _HeaderSection(
                    name: name,
                    imageUrl: imageUrl,
                    cuisine: cuisine,
                    category: category,
                  ),
                  const SizedBox(height: AppConstants.largePadding),
                  _QuickActionsSection(
                    phone: phone,
                    address: address,
                    location: location,
                    email: email,
                    name: name,
                  ),
                  const SizedBox(height: AppConstants.mediumPadding),
                  _BusinessInfoCard(
                    cuisine: cuisine,
                    category: category,
                    location: location,
                    rating: rating,
                    status: status,
                  ),
                  _ContactInfoCard(phone: phone, email: email),
                  _LocationCard(
                    address: address,
                    location: location,
                    name: name,
                  ),
                  _ServicesCard(services: services),
                  _FeaturesCard(features: features),
                  _WorkingHoursCard(workingHours: workingHours),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppTheme.cardColor,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text(
          'حول المنتج',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor.withOpacity(0.05),
                AppTheme.secondaryColor,
              ],
            ),
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(
            left: AppConstants.mediumPadding,
            top: AppConstants.smallPadding,
            bottom: AppConstants.smallPadding,
          ),
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(
              AppConstants.defaultBorderRadius,
            ),
            boxShadow: AppTheme.buttonShadow,
          ),
          child: IconButton(
            icon: const Icon(Icons.close, color: AppTheme.textPrimary),
            onPressed: () => Navigator.pop(context),
            tooltip: 'إغلاق',
          ),
        ),
      ],
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String? cuisine;
  final String? category;

  const _HeaderSection({
    required this.name,
    this.imageUrl,
    this.cuisine,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.mediumPadding,
      ),
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: [
          _ProductImage(name: name, imageUrl: imageUrl),
          const SizedBox(height: 20),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
            semanticsLabel: 'اسم المنتج: $name',
          ),
          const SizedBox(height: 12),
          if (cuisine != null || category != null)
            _CategoryChip(text: cuisine ?? category!),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String name;
  final String? imageUrl;

  const _ProductImage({required this.name, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'product_image_$name',
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(AppConstants.largePadding),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.15),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.largePadding),
          child:
              imageUrl != null
                  ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    semanticLabel: 'صورة $name',
                    errorBuilder:
                        (context, error, stackTrace) => _DefaultImage(),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  )
                  : _DefaultImage(),
        ),
      ),
    );
  }

  Widget _DefaultImage() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      child: Image.asset(
        AppAssets.neuss,
        fit: BoxFit.contain,
        semanticLabel: 'الصورة الافتراضية',
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String text;

  const _CategoryChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.mediumPadding,
        vertical: AppConstants.smallPadding,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.1),
            AppTheme.secondaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        semanticsLabel: 'فئة المنتج: $text',
      ),
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  final String? phone;
  final String? address;
  final String? location;
  final String? email;
  final String name;

  const _QuickActionsSection({
    this.phone,
    this.address,
    this.location,
    this.email,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];

    if (phone != null) {
      actions.add(
        _QuickActionButton(
          icon: Icons.phone,
          label: 'اتصال',
          color: AppTheme.successColor,
          onTap: () => _showCallDialog(context),
        ),
      );
    }

    if (address != null || location != null) {
      actions.add(
        _QuickActionButton(
          icon: Icons.location_on,
          label: 'الموقع',
          color: AppTheme.primaryColor,
          onTap: () => _openGoogleMaps(context),
        ),
      );
    }

    if (email != null) {
      actions.add(
        _QuickActionButton(
          icon: Icons.email,
          label: 'إيميل',
          color: AppTheme.warningColor,
          onTap: () => UrlLauncherService.sendEmail(email!, context),
        ),
      );
    }

    if (actions.isEmpty) return const SizedBox.shrink();

    List<Widget> rowChildren = [];
    for (int i = 0; i < actions.length; i++) {
      rowChildren.add(Expanded(child: actions[i]));
      if (i < actions.length - 1) {
        rowChildren.add(const SizedBox(width: 12));
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.mediumPadding,
      ),
      child: Row(children: rowChildren),
    );
  }

  void _showCallDialog(BuildContext context) {
    final phoneNumber = phone ?? AppConstants.defaultPhoneNumber;
    showDialog(
      context: context,
      builder: (context) => _CallDialog(phoneNumber: phoneNumber),
    );
  }

  void _openGoogleMaps(BuildContext context) {
    final searchQuery = address ?? location ?? name;
    UrlLauncherService.openGoogleMaps(searchQuery, context);
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.mediumPadding),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.mediumPadding),
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(AppConstants.mediumPadding),
            border: Border.all(color: color.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: AppConstants.smallPadding),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CallDialog extends StatelessWidget {
  final String phoneNumber;

  const _CallDialog({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.largePadding),
      ),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.largePadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.largePadding),
          color: AppTheme.cardColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone,
                size: 32,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: AppConstants.mediumPadding),
            const Text(
              'الاتصال بالرقم',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            Text(
              phoneNumber,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.largePadding),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.defaultBorderRadius,
                        ),
                        side: const BorderSide(color: AppTheme.borderColor),
                      ),
                    ),
                    child: const Text(
                      'إلغاء',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await UrlLauncherService.makePhoneCall(
                        phoneNumber,
                        context,
                      );
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.defaultBorderRadius,
                        ),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'الاتصال',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Information Cards
class _BusinessInfoCard extends StatelessWidget {
  final String? cuisine;
  final String? category;
  final String? location;
  final String? rating;
  final String? status;

  const _BusinessInfoCard({
    this.cuisine,
    this.category,
    this.location,
    this.rating,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> infoRows = [];

    if (cuisine != null || category != null) {
      infoRows.add(
        _InfoRow(
          label: 'النوع',
          value: cuisine ?? category!,
          icon: Icons.category,
        ),
      );
    }
    if (location != null) {
      infoRows.add(
        _InfoRow(label: 'المنطقة', value: location!, icon: Icons.location_city),
      );
    }
    if (rating != null) {
      infoRows.add(
        _InfoRow(
          label: 'التقييم',
          value: rating!,
          icon: Icons.star,
          valueColor: AppTheme.warningColor,
        ),
      );
    }
    if (status != null) {
      infoRows.add(
        _InfoRow(
          label: 'الحالة',
          value: status!,
          icon: Icons.access_time,
          valueColor:
              status!.contains('مفتوح') || status!.contains('توصيل')
                  ? AppTheme.successColor
                  : AppTheme.errorColor,
        ),
      );
    }

    if (infoRows.isEmpty) return const SizedBox.shrink();

    return _InfoCard(
      title: 'معلومات الأعمال',
      titleIcon: Icons.business,
      children: infoRows,
    );
  }
}

class _ContactInfoCard extends StatelessWidget {
  final String? phone;
  final String? email;

  const _ContactInfoCard({this.phone, this.email});

  @override
  Widget build(BuildContext context) {
    List<Widget> contactRows = [];

    if (phone != null) {
      contactRows.add(
        _ContactRow(
          label: 'رقم التليفون',
          value: phone!,
          icon: Icons.phone,
          onTap: () => _showCallDialog(context),
        ),
      );
    }
    if (email != null) {
      contactRows.add(
        _ContactRow(
          label: 'البريد الإلكتروني',
          value: email!,
          icon: Icons.email,
          onTap: () => UrlLauncherService.sendEmail(email!, context),
        ),
      );
    }

    if (contactRows.isEmpty) return const SizedBox.shrink();

    return _InfoCard(
      title: 'معلومات التواصل',
      titleIcon: Icons.contact_phone,
      children: contactRows,
    );
  }

  void _showCallDialog(BuildContext context) {
    final phoneNumber = phone ?? AppConstants.defaultPhoneNumber;
    showDialog(
      context: context,
      builder: (context) => _CallDialog(phoneNumber: phoneNumber),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final String? address;
  final String? location;
  final String name;

  const _LocationCard({this.address, this.location, required this.name});

  @override
  Widget build(BuildContext context) {
    if (address == null && location == null) return const SizedBox.shrink();

    return _InfoCard(
      title: 'الموقع',
      titleIcon: Icons.location_on,
      children: [
        if (address != null)
          _InfoRow(label: 'العنوان', value: address!, icon: Icons.location_on)
        else if (location != null)
          _InfoRow(
            label: 'المنطقة',
            value: location!,
            icon: Icons.location_city,
          ),
        _ActionRow(
          label: 'عرض على الخريطة',
          icon: Icons.map,
          onTap: () => _openGoogleMaps(context),
        ),
      ],
    );
  }

  void _openGoogleMaps(BuildContext context) {
    final searchQuery = address ?? location ?? name;
    UrlLauncherService.openGoogleMaps(searchQuery, context);
  }
}

class _ServicesCard extends StatelessWidget {
  final List<String>? services;

  const _ServicesCard({this.services});

  @override
  Widget build(BuildContext context) {
    if (services == null || services!.isEmpty) return const SizedBox.shrink();

    return _InfoCard(
      title: 'الخدمات',
      titleIcon: Icons.room_service,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.mediumPadding,
            vertical: AppConstants.smallPadding,
          ),
          child: Wrap(
            spacing: AppConstants.smallPadding,
            runSpacing: AppConstants.smallPadding,
            children:
                services!
                    .map((service) => _ServiceChip(service: service))
                    .toList(),
          ),
        ),
      ],
    );
  }
}

class _FeaturesCard extends StatelessWidget {
  final List<String>? features;

  const _FeaturesCard({this.features});

  @override
  Widget build(BuildContext context) {
    if (features == null || features!.isEmpty) return const SizedBox.shrink();

    return _InfoCard(
      title: 'المميزات',
      titleIcon: Icons.stars,
      children:
          features!.map((feature) => _FeatureRow(feature: feature)).toList(),
    );
  }
}

class _WorkingHoursCard extends StatelessWidget {
  final Map<String, String>? workingHours;

  const _WorkingHoursCard({this.workingHours});

  @override
  Widget build(BuildContext context) {
    if (workingHours == null || workingHours!.isEmpty)
      return const SizedBox.shrink();

    return _InfoCard(
      title: 'ساعات العمل',
      titleIcon: Icons.schedule,
      children:
          workingHours!.entries
              .map(
                (entry) => _WorkingHourRow(day: entry.key, hours: entry.value),
              )
              .toList(),
    );
  }
}

// Reusable Components
class _InfoCard extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  final List<Widget> children;

  const _InfoCard({
    required this.title,
    required this.titleIcon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: AppConstants.mediumPadding,
        right: AppConstants.mediumPadding,
        bottom: AppConstants.mediumPadding,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        boxShadow: AppTheme.lightShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    titleIcon,
                    color: AppTheme.primaryColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppTheme.borderColor,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          ...children,
          const SizedBox(height: AppConstants.smallPadding),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: (valueColor ?? AppTheme.textSecondary).withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.smallPadding),
            ),
            child: Icon(
              icon,
              color: valueColor ?? AppTheme.textSecondary,
              size: AppConstants.iconSize,
            ),
          ),
          const SizedBox(width: AppConstants.mediumPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: valueColor ?? AppTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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

class _ContactRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const _ContactRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.mediumPadding,
            vertical: 4,
          ),
          padding: const EdgeInsets.all(AppConstants.mediumPadding),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(
              AppConstants.defaultBorderRadius,
            ),
            border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    AppConstants.smallPadding,
                  ),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: AppConstants.iconSize,
                ),
              ),
              const SizedBox(width: AppConstants.mediumPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppTheme.primaryColor,
                  size: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionRow({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.mediumPadding,
            vertical: AppConstants.smallPadding,
          ),
          padding: const EdgeInsets.all(AppConstants.mediumPadding),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(
              AppConstants.defaultBorderRadius,
            ),
            border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    AppConstants.smallPadding,
                  ),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: AppConstants.iconSize,
                ),
              ),
              const SizedBox(width: AppConstants.mediumPadding),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppTheme.primaryColor,
                  size: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceChip extends StatelessWidget {
  final String service;

  const _ServiceChip({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.mediumPadding,
        vertical: AppConstants.smallPadding,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.1),
            AppTheme.secondaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
      ),
      child: Text(
        service,
        style: const TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String feature;

  const _FeatureRow({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: AppConstants.smallPadding,
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.smallPadding),
            ),
            child: const Icon(
              Icons.check_circle,
              color: AppTheme.successColor,
              size: AppConstants.iconSize,
            ),
          ),
          const SizedBox(width: AppConstants.mediumPadding),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(color: AppTheme.textPrimary, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkingHourRow extends StatelessWidget {
  final String day;
  final String hours;

  const _WorkingHourRow({required this.day, required this.hours});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.mediumPadding,
        vertical: 4,
      ),
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            hours,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
