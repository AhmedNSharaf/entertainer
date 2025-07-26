import 'package:enter_tainer/app/controllers/favourite_controller.dart';
import 'package:enter_tainer/app/views/modules/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoritesController =
        Get.find<FavoritesController>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'مفضلاتك',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Color(0xFF0057FF),
            unselectedLabelColor: Colors.black54,
            indicatorColor: Color(0xFF0057FF),
            indicatorWeight: 3,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            tabs: [Tab(text: 'المنافذ'), Tab(text: 'المنتجات')],
          ),
        ),
        body: TabBarView(
          children: [
            // تبويب المنافذ
            Obx(
              () =>
                  favoritesController.favoriteOutlets.isEmpty
                      ? _buildEmptyState(
                        icon: Icons.store_outlined,
                        title: 'لا توجد منافذ مفضلة',
                        subtitle:
                            'ابدأ في إضافة منافذ البيع إلى مفضلاتك من خلال النقر فوق \u2661',
                        buttonText: 'استكشف المنافذ',
                      )
                      : _buildFavoritesList(
                        favoritesController.favoriteOutlets,
                      ),
            ),

            // تبويب المنتجات
            Obx(
              () =>
                  favoritesController.favoriteProducts.isEmpty
                      ? _buildEmptyState(
                        icon: Icons.favorite_border,
                        title: 'لا توجد منتجات مفضلة',
                        subtitle:
                            'ابدأ في إضافة المنتجات إلى مفضلاتك من خلال النقر فوق \u2661',
                        buttonText: 'استكشف المنتجات',
                      )
                      : _buildProductsList(
                        favoritesController.favoriteProducts,
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesList(List<Map<String, dynamic>> outlets) {
    return ListView.builder(
      itemCount: outlets.length,
      itemBuilder: (context, index) {
        final outlet = outlets[index];
        return ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(outlet['image'])),
          title: Text(outlet['name']),
          trailing: IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Get.find<FavoritesController>().toggleOutletFavorite(outlet);
            },
          ),
        );
      },
    );
  }

  Widget _buildProductsList(List<Map<String, dynamic>> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Image.network(
              product['image'],
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(product['name']),
            subtitle: Text('${product['price']} د.ك'),
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                Get.find<FavoritesController>().toggleProductFavorite(product);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Icon(icon, size: 100, color: Colors.black12),
        const SizedBox(height: 32),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Get.off(() => MainScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0057FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
