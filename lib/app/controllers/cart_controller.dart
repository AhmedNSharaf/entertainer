import 'package:get/get.dart';

class CartController extends GetxController {
  // Map to store product quantities
  var productQuantities = <String, int>{}.obs;
  
  // List of products (to access details like name, price, etc.)
  var products = <Map<String, dynamic>>[].obs;
  
  // Add or update product in cart
  void addProduct(Map<String, dynamic> product, int quantity) {
    if (quantity <= 0) {
      // Remove product completely when quantity is 0 or less
      productQuantities.remove(product['id']);
      products.removeWhere((item) => item['id'] == product['id']);
    } else {
      productQuantities[product['id']] = quantity;
      // Add product details if not already in the list
      if (!products.any((item) => item['id'] == product['id'])) {
        products.add(product);
      }
    }
    update(); // Notify listeners
  }
  
  // Increase product quantity
  void increaseQuantity(Map<String, dynamic> product) {
    int currentQty = getProductQuantity(product['id']);
    addProduct(product, currentQty + 1);
  }
  
  // Decrease product quantity
  void decreaseQuantity(Map<String, dynamic> product) {
    int currentQty = getProductQuantity(product['id']);
    if (currentQty > 1) {
      addProduct(product, currentQty - 1);
    } else {
      // Remove product when quantity would become 0
      removeProduct(product['id']);
    }
  }
  
  // Remove product from cart completely
  void removeProduct(String productId) {
    productQuantities.remove(productId);
    products.removeWhere((item) => item['id'] == productId);
    update();
  }
  
  // Get quantity of a specific product
  int getProductQuantity(String productId) {
    return productQuantities[productId] ?? 0;
  }
  
  // Calculate subtotal
  double getSubtotal() {
    double subtotal = 0.0;
    for (var product in products) {
      int quantity = productQuantities[product['id']] ?? 0;
      double price = double.tryParse(product['price'].toString().replaceAll(' د.ك', '')) ?? 0.0;
      subtotal += price * quantity;
    }
    return subtotal;
  }
  
  // Calculate total (including delivery and service fees)
  double getTotal() {
    const double deliveryFee = 8.5;
    const double serviceFee = 2.95;
    return getSubtotal() + deliveryFee + serviceFee;
  }
  
  // Get total number of items in cart
  int getTotalItemsCount() {
    return productQuantities.values.fold(0, (sum, quantity) => sum + quantity);
  }
  
  // Clear entire cart
  void clearCart() {
    productQuantities.clear();
    products.clear();
    update();
  }
}