import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final RxList<Map<String, dynamic>> favoriteProducts = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> favoriteOutlets = <Map<String, dynamic>>[].obs;

  void toggleProductFavorite(Map<String, dynamic> product) {
    if (favoriteProducts.any((p) => p['id'] == product['id'])) {
      favoriteProducts.removeWhere((p) => p['id'] == product['id']);
    } else {
      favoriteProducts.add(product);
    }
    update();
  }

  void toggleOutletFavorite(Map<String, dynamic> outlet) {
    if (favoriteOutlets.any((o) => o['id'] == outlet['id'])) {
      favoriteOutlets.removeWhere((o) => o['id'] == outlet['id']);
    } else {
      favoriteOutlets.add(outlet);
    }
    update();
  }

  bool isProductFavorite(String productId) {
    return favoriteProducts.any((p) => p['id'] == productId);
  }

  bool isOutletFavorite(String outletId) {
    return favoriteOutlets.any((o) => o['id'] == outletId);
  }
}