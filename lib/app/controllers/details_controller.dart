import 'package:get/get.dart';

class DetailsController extends GetxController {
  var subCategories = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubCategories();
  }

  void fetchSubCategories() async {
    isLoading.value = true;

    try {
      await Future.delayed(Duration(seconds: 2)); // simulate loading

      final response = {
        "data": List.generate(8, (index) => {
          "image": "https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg",
          "name": "مطعم ${index + 1}",
          "location": "ديرة",
          "cuisine": "سوري · فلافل",
          "rating": 4.3,
          "isFeatured": true,
          "monthlyOffer": false,
          "delivery": true,
          "deliveryOnly": false,
          "distance": 7.8,
        })
      };

      subCategories.value = List<Map<String, dynamic>>.from(response["data"]!);
    } catch (e) {
      print("Error fetching subcategories: $e");
    }

    isLoading.value = false;
  }
}
