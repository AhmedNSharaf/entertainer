import 'package:enter_tainer/app/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'details_grid_view.dart';

class MainGridViewCategory extends StatelessWidget {
  final CategoryController controller = Get.put(CategoryController());

  MainGridViewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.error.isNotEmpty) {
        return Center(child: Text('Error: ${controller.error}'));
      }

      if (controller.categories.isEmpty) {
        return const Center(child: Text('No categories available'));
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 14,
          crossAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];

          return LayoutBuilder(
            builder: (context, constraints) {
              return Card(
                elevation: 3,
                color: Colors.white,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    // Create subcategory data from API subcategories
                    final subCategoriesData = category.subCategories.map((subCat) {
                      return {
                        "id": subCat.id,
                        "name": subCat.name,
                        "description": subCat.description ?? "",
                        "image": subCat.image ?? "https://img.icons8.com/color/48/food.png",
                        "categoryId": subCat.categoryId,
                        // Add default values for filtering
                        "location": "غير محدد",
                        "cuisine": "متنوع", 
                        "rating": 4.0,
                        "isFeatured": false,
                        "monthlyOffer": false,
                        "delivery": true,
                        "deliveryOnly": false,
                        "distance": 5.0,
                      };
                    }).toList();

                    // If no subcategories, use products instead
                    final dataToPass = subCategoriesData.isNotEmpty 
                        ? subCategoriesData 
                        : category.products.map((product) {
                            return {
                              "id": product.id,
                              "name": product.name,
                              "description": product.description,
                              "image": product.image,
                              "price": product.price,
                              "location": "غير محدد",
                              "cuisine": "متنوع",
                              "rating": 4.0,
                              "isFeatured": product.offerType.isNotEmpty,
                              "monthlyOffer": product.offerValidUntil.isAfter(DateTime.now()),
                              "delivery": true,
                              "deliveryOnly": false,
                              "distance": 5.0,
                            };
                          }).toList();

                    Get.to(
                      () => DetailsGridView(
                        label: category.name,
                        subCategories: dataToPass,
                        categoryId: category.id, // Pass category ID for potential API calls
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: NetworkImage(
                          category.image ?? "https://img.icons8.com/color/48/food.png",
                        ),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            category.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }
}