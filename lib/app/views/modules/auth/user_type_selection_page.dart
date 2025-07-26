import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neuss_utils/utils/constants.dart';
import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/utils/app_colors.dart';
import 'package:neuss_utils/widgets/src/txt.dart';

enum UserType { user, supplier }

class SelectUserTypePage extends StatelessWidget {
  const SelectUserTypePage({super.key});

  void goToRegister(UserType type) {
    Get.toNamed(
      Routes.SIGNUP,
      parameters: {'type': type.toString().split('.').last},
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'اختر نوع الحساب',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 32.0 : 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Header Section
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.appMainColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_add_alt_1,
                          size: 40,
                          color: AppColors.appMainColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Txt(
                        'مرحباً بك!',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                      const SizedBox(height: 8),
                      Txt(
                        'اختر نوع الحساب الذي تريد إنشاؤه',
                        fontSize: 16,
                        color: Colors.grey,
                        textAlign: TextAlign.center,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // User Options
                _buildAnimatedOption(
                  icon: Icons.person_outline,
                  title: 'عميل / مستخدم',
                  description: 'أريد الحصول على خدمات من مقدمي الخدمات',
                  color: AppColors.appMainColor,
                  onTap: () => goToRegister(UserType.user),
                  delay: 100,
                ),

                const SizedBox(height: 20),

                _buildAnimatedOption(
                  icon: Icons.work_outline,
                  title: 'مقدم خدمة',
                  description: 'أريد تقديم خدماتي للعملاء والحصول على دخل',
                  color: Colors.orange,
                  onTap: () => goToRegister(UserType.supplier),
                  delay: 200,
                ),

                const SizedBox(height: 40),

                // Footer
                Center(
                  child: Column(
                    children: [
                      Txt(
                        'يمكنك تغيير نوع الحساب لاحقاً من الإعدادات',
                        fontSize: 12,
                        color: Colors.grey,
                        textAlign: TextAlign.center,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          // Navigate to help or FAQ
                        },
                        child: Txt(
                          'هل تحتاج مساعدة؟',
                          fontSize: 14,
                          color: Colors.blue,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedOption({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.3), width: 1),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 32, color: color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Txt(
                        title,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                      const SizedBox(height: 6),
                      Txt(
                        description,
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ],
                  ),
                ),
                hSpace16,
                Icon(Icons.arrow_forward_ios, color: color, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
