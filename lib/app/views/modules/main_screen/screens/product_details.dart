import 'package:enter_tainer/app/controllers/favourite_controller.dart';
import 'package:enter_tainer/app/views/modules/Drawer/Notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/widgets/src/txt.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import '../../../widgets/Product/product_cupon.dart';
import '../widgets/about_product.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.productName,
    required this.label,
    this.restaurantData,
  });
  final String productName;
  final String label;
  final Map<String, dynamic>? restaurantData;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with SingleTickerProviderStateMixin {
  final List<String> images = [
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400&q=60',
    'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60',
    'https://images.unsplash.com/photo-1528605248644-14dd04022da1?w=400&q=60',
    'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?w=400&q=60',
  ];
  int currentIndex = 0;
  bool expanded = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final FavoritesController favoritesController =
      Get.find<FavoritesController>();

  final String description =
      'من خلال إحياء ثقافة بريطانيا النابضة بالحياة، يقدم ذا أندرغراوند جميع الألعاب المفضلة بدءاً من ليالي المسابقات والترفيه المباشر وحتى عرض أحدث الأحداث الرياضية. بالإضافة إلى ذلك، فإن القائمة اللذيذة من الأطباق والمشروبات ستجعل تجربتك لا تُنسى. المكان مثالي للأصدقاء والعائلات ويقدم أجواء رائعة طوال الأسبوع مع فعاليات متنوعة.';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final data = widget.restaurantData ?? {};

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: CustomScrollView(
          slivers: [
            // App Bar with gradient
            SliverAppBar(
              expandedHeight: Get.height * 0.35,
              floating: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _iconBtn(Icons.phone, onPressed: _callPhone),
                      _iconBtn(Icons.share, onPressed: _showShareSheet),
                      _iconBtn(Icons.mail_outline, onPressed: _sendEmail),
                      Obx(
                        () => _iconBtn(
                          favoritesController.isOutletFavorite(
                                widget.productName,
                              )
                              ? Icons.favorite
                              : Icons.favorite_border,
                          onPressed: _toggleFavorite,
                          color:
                              favoritesController.isOutletFavorite(
                                    widget.productName,
                                  )
                                  ? Colors.red
                                  : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image slider
                    PageView.builder(
                      itemCount: images.length,
                      onPageChanged: (i) => setState(() => currentIndex = i),
                      itemBuilder:
                          (context, i) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(images[i]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                    // Dots indicator
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          images.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: currentIndex == i ? 30 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color:
                                  currentIndex == i
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Content
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Title and rating section
                        _buildTitleSection(),
                        const SizedBox(height: 16),

                        // Description section
                        _buildDescriptionSection(),
                        const SizedBox(height: 20),

                        // Location section
                        _buildLocationSection(),
                        const SizedBox(height: 24),

                        // Action buttons
                        _buildActionButtons(data),
                        const SizedBox(height: 24),

                        // Coupon section
                        _buildCouponSection(),
                        const SizedBox(height: 24),

                        // Address section
                        _buildAddressSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.productName,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.amber.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  '4.3',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.star, color: Colors.amber, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedCrossFade(
            firstChild: Text(
              description,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.6,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            secondChild: Text(
              description,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.6,
              ),
            ),
            crossFadeState:
                expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => setState(() => expanded = !expanded),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    expanded ? 'اقرأ أقل' : 'المزيد',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue[50]!, Colors.blue[100]!]),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Row(
        children: const [
          Icon(Icons.location_on, color: Colors.blue, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'ذا أندرغراوند منتجع الحبتور جراند، أوتوجراف كولكشن',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> data) {
    return Row(
      children: [
        Expanded(
          child: _actionButton(Icons.info_outline, 'حول', Colors.green, () {
            Get.to(
              AboutProduct(
                name: 'Abo Ali',
                address: 'ismailia',
                category: 'Food',
                email: 'ahmednabil@gmail.com',
                phone: '01111111111',
                location: 'ismailia',
                imageUrl: 'assets/images/donation_image_bg.png',
                rating: '4',
                services: ['Food', 'Drinks'],
                features: ['Wifi', 'Parking'],
                status: 'Open',
                workingHours: {'from': '10:00', 'to': '22:00'},
              ),
            );
          }),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _actionButton(Icons.menu_book, 'القائمة', Colors.orange, () {
            Get.to(() => AboutProduct(name: widget.label));
          }),
        ),
        const SizedBox(width: 12),
        Expanded(child: _actionButton(Icons.map, 'خريطة', Colors.blue, () {})),
      ],
    );
  }

  Widget _actionButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const ProductCupon(),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: const [
            Icon(Icons.location_city, color: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: Txt('العنوان', fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 100), // Extra space at bottom
      ],
    );
  }

  Widget _iconBtn(IconData icon, {VoidCallback? onPressed, Color? color}) =>
      IconButton(
        icon: Icon(icon, color: color ?? Colors.white),
        onPressed: onPressed,
      );

  void _toggleFavorite() {
    final product = {
      'id': widget.productName,
      'name': widget.productName,
      'label': widget.label,
      'image': images.isNotEmpty ? images[0] : '',
      'price': '0.0',
    };

    favoritesController.toggleOutletFavorite(product);
  }

  void _callPhone() async {
    const phone = '01018027405';
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showSnackBar('لا يمكن إجراء الاتصال');
    }
  }

  void _sendEmail() async {
    const email = 'omarragab712000@gmail.com';
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=استفسار&body=مرحباً',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showDialog(
        'تنبيه',
        'يرجى تثبيت تطبيق بريد إلكتروني (مثل Gmail) على جهازك.',
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('حسناً'),
              ),
            ],
          ),
    );
  }

  void _showShareSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      builder:
          (context) => _ShareBottomSheet(
            shareUrl: images.isNotEmpty ? images[currentIndex] : '',
            shareText: widget.label,
          ),
    );
  }
}

class _ShareBottomSheet extends StatelessWidget {
  final String shareUrl;
  final String shareText;

  const _ShareBottomSheet({required this.shareUrl, required this.shareText});

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
              _ShareIconButton(
                icon: Icons.facebook,
                label: 'Facebook',
                color: const Color(0xFF1877F3),
                onTap: () => _shareToFacebook(),
              ),
              _ShareIconButton(
                icon: FontAwesomeIcons.whatsapp,
                label: 'WhatsApp',
                color: const Color(0xFF25D366),
                onTap: () => _shareToWhatsApp(),
              ),
              _ShareIconButton(
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

class _ShareIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ShareIconButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
