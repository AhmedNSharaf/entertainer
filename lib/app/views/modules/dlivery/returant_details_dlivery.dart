import 'package:enter_tainer/app/controllers/cart_controller.dart';
import 'package:enter_tainer/app/controllers/favourite_controller.dart';
import 'package:enter_tainer/app/views/modules/dlivery/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/widgets/src/txt.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  const RestaurantDetailsScreen({Key? key, required this.title})
    : super(key: key);
  final String title;
  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  final FavoritesController favoritesController = Get.put(
    FavoritesController(),
  );

  final List<String> images = [
    'https://cdhf.ca/wp-content/uploads/2023/01/fast-food.webp',
    'https://www.summahealth.org/-/media/project/summahealth/website/page-content/flourish/2_18a_fl_fastfood_400x400.webp?la=en&h=400&w=400&hash=145DC0CF6234A159261389F18A36742A',
    'https://m.media-amazon.com/images/I/8100Djfg4+L._UF1000,1000_QL80_.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRw06qvcHivNTNdx7LNvfddhFzkqbpZo7G2m-I1XJIRYxNibjrywhvRd0Anz7zvTk11O5k&usqp=CAU',
    'https://cdn.langeek.co/photo/36511/original/fast-food?type=jpeg',
  ];

  int currentImage = 0;
  int selectedCategoryIndex = 0;
  bool isAppBarExpanded = true;

  // Initialize CartController
  final CartController cartController = Get.put(CartController());

  // بيانات الفئات والمنتجات
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Top Up',
      'products': [
        {
          'id': 'pizza_margherita',
          'name': 'بيتزا مارجريتا',
          'description': 'صلصة طماطم، جبنة موزاريلا، ريحان طازج',
          'price': '25.00',
          'image':
              'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400',
          'rating': 4.5,
          'preparationTime': '20-25 دقيقة',
        },
        {
          'id': 'pizza_pepperoni',
          'name': 'بيتزا بيبروني',
          'description': 'بيبروني، جبنة موزاريلا، صلصة طماطم',
          'price': '28.00',
          'image':
              'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
          'rating': 4.3,
          'preparationTime': '18-22 دقيقة',
        },
      ],
    },
    {
      'name': 'Desserts',
      'products': [
        {
          'id': 'cheesecake',
          'name': 'تشيز كيك',
          'description': 'تشيز كيك كلاسيكي مع توت طازج',
          'price': '15.00',
          'image':
              'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=400',
          'rating': 4.8,
          'preparationTime': '5-10 دقيقة',
        },
        {
          'id': 'vanilla_ice_cream',
          'name': 'آيس كريم فانيليا',
          'description': 'آيس كريم فانيليا مع شوكولاتة',
          'price': '12.00',
          'image':
              'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=400',
          'rating': 4.2,
          'preparationTime': '3-5 دقيقة',
        },
        {
          'id': 'chocolate_brownie',
          'name': 'براوني شوكولاتة',
          'description': 'براوني شوكولاتة دافئ مع آيس كريم',
          'price': '18.00',
          'image':
              'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=400',
          'rating': 4.6,
          'preparationTime': '8-12 دقيقة',
        },
      ],
    },
    {
      'name': 'Smoothies',
      'products': [
        {
          'id': 'strawberry_smoothie',
          'name': 'سموثي الفراولة',
          'description': 'فراولة طازجة مع حليب وموز',
          'price': '18.00',
          'image':
              'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=400',
          'rating': 4.4,
          'preparationTime': '5-8 دقيقة',
        },
        {
          'id': 'mango_smoothie',
          'name': 'سموثي المانجو',
          'description': 'مانجو طازج مع أناناس وبرتقال',
          'price': '20.00',
          'image':
              'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=400',
          'rating': 4.5,
          'preparationTime': '5-8 دقيقة',
        },
        {
          'id': 'blueberry_smoothie',
          'name': 'سموثي التوت الأزرق',
          'description': 'توت أزرق مع زبادي يوناني',
          'price': '22.00',
          'image':
              'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=400',
          'rating': 4.3,
          'preparationTime': '5-8 دقيقة',
        },
      ],
    },
    {
      'name': 'Salads',
      'products': [
        {
          'id': 'caesar_salad',
          'name': 'سلطة سيزر',
          'description': 'خس روماني، كروتون، جبنة بارميزان',
          'price': '22.00',
          'image':
              'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400',
          'rating': 4.2,
          'preparationTime': '10-15 دقيقة',
        },
        {
          'id': 'greek_salad',
          'name': 'سلطة يونانية',
          'description': 'خيار، طماطم، زيتون، جبنة فيتا',
          'price': '20.00',
          'image':
              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
          'rating': 4.4,
          'preparationTime': '8-12 دقيقة',
        },
        {
          'id': 'caprese_salad',
          'name': 'سلطة كابريز',
          'description': 'طماطم، موزاريلا، ريحان طازج',
          'price': '24.00',
          'image':
              'https://images.unsplash.com/photo-1551248429-40975aa4de74?w=400',
          'rating': 4.6,
          'preparationTime': '10-15 دقيقة',
        },
      ],
    },
    {
      'name': 'Super Grill',
      'products': [
        {
          'id': 'beef_steak',
          'name': 'ستيك لحم',
          'description': 'ستيك لحم مشوي مع خضروات',
          'price': '45.00',
          'image':
              'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400',
          'rating': 4.8,
          'preparationTime': '25-30 دقيقة',
        },
        {
          'id': 'grilled_chicken',
          'name': 'دجاج مشوي',
          'description': 'دجاج مشوي مع صلصة خاصة',
          'price': '35.00',
          'image':
              'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?w=400',
          'rating': 4.5,
          'preparationTime': '20-25 دقيقة',
        },
        {
          'id': 'grilled_fish',
          'name': 'سمك مشوي',
          'description': 'سمك سالمون مشوي مع ليمون',
          'price': '40.00',
          'image':
              'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400',
          'rating': 4.7,
          'preparationTime': '22-28 دقيقة',
        },
      ],
    },
  ];

  // دالة للحصول على كمية المنتج
  int getProductQuantity(String productId) {
    return cartController.getProductQuantity(productId);
  }

  // دالة لتحديث كمية المنتج
  void updateProductQuantity(
    String productId,
    int quantity,
    Map<String, dynamic> product,
  ) {
    cartController.addProduct(product, quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
          elevation: 2,
          onPressed: () {
            Get.to(() => CartProduct());
          },
          label: const Txt(
            'عرض السلة',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.red),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels > 100 && isAppBarExpanded) {
              setState(() {
                isAppBarExpanded = false;
              });
            } else if (scrollInfo.metrics.pixels <= 100 && !isAppBarExpanded) {
              setState(() {
                isAppBarExpanded = true;
              });
            }
            return true;
          },
          child: CustomScrollView(
            slivers: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: SliverAppBar(
                  pinned: true,
                  expandedHeight: 250,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  foregroundColor: Colors.black,
                  centerTitle: true,
                  title: AnimatedOpacity(
                    opacity: isAppBarExpanded ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  actions: [
                    // أيقونة المفضلة
                    Obx(
                      () => IconButton(
                        icon: Icon(
                          favoritesController.isOutletFavorite(widget.title)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          favoritesController.toggleOutletFavorite({
                            'id': widget.title,
                            'name': widget.title,
                            'image': images[0],
                          });
                        },
                      ),
                    ),
                    // أيقونة المشاركة
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.black),
                      onPressed: () {
                        _showShareDialog();
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    expandedTitleScale: 1.25,
                    titlePadding: const EdgeInsetsDirectional.only(
                      start: 0,
                      bottom: 16,
                      end: 0,
                    ),
                    stretchModes: const [
                      StretchMode.zoomBackground,
                      StretchMode.fadeTitle,
                    ],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        // صور المطعم
                        PageView.builder(
                          itemCount: images.length,
                          onPageChanged:
                              (i) => setState(() => currentImage = i),
                          itemBuilder:
                              (context, index) => Image.network(
                                images[index],
                                fit: BoxFit.cover,
                              ),
                        ),
                        // مؤشرات الصور
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              images.length,
                              (i) => Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                width: currentImage == i ? 12 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color:
                                      currentImage == i
                                          ? Colors.white
                                          : Colors.white54,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    collapseMode: CollapseMode.parallax,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'برجمان',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'دولي • مطاعم غير رسمية وطلبات خارجية',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xfff3f7ff),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.local_offer_outlined),
                              const SizedBox(width: 16),
                              const Text(
                                'اشترك لإلغاء تأمين العرض',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              const Text(
                                'اشترك الآن ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurpleAccent,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.14,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 16),
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "2FOR1",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "بيتزا حجم كبير",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              "صالح لغاية 30-2028",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        const Icon(Icons.home_filled, size: 16),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            categories.length,
                            (index) => _buildCategoryTab(
                              categories[index]['name'],
                              index,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 0),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            categories[selectedCategoryIndex]['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...List.generate(
                            categories[selectedCategoryIndex]['products']
                                .length,
                            (index) => _buildProductCard(
                              categories[selectedCategoryIndex]['products'][index],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showShareDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('مشاركة المطعم'),
          content: const Text('اختر طريقة المشاركة'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('WhatsApp'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Facebook'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Twitter'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء'),
            ),
          ],
        );
      },
    );
  }

  void _showProductBottomSheet(Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(product['image'], fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product['description'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            product['rating'].toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.access_time, color: Colors.grey, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            product['preparationTime'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product['price']} د.ك',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              updateProductQuantity(
                                product['id'],
                                getProductQuantity(product['id']) + 1,
                                product,
                              );
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              'أضف للسلة',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryTab(String label, int index) {
    final isSelected = selectedCategoryIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategoryIndex = index;
          });
        },
        child: Chip(
          label: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor: isSelected ? Colors.red : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        _showProductBottomSheet(product);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product['description'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          product['rating'].toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.access_time, color: Colors.grey, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          product['preparationTime'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${product['price']} د.ك',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () =>
                        getProductQuantity(product['id']) == 0
                            ? ElevatedButton(
                              onPressed: () {
                                updateProductQuantity(
                                  product['id'],
                                  1,
                                  product,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text('أضف'),
                            )
                            : Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      updateProductQuantity(
                                        product['id'],
                                        getProductQuantity(product['id']) > 1
                                            ? getProductQuantity(
                                                  product['id'],
                                                ) -
                                                1
                                            : 0,
                                        product,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '${getProductQuantity(product['id'])}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () {
                                      updateProductQuantity(
                                        product['id'],
                                        getProductQuantity(product['id']) + 1,
                                        product,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
