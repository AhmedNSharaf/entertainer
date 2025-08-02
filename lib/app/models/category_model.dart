import 'product_model.dart';
import 'sub_category_model.dart';

class CategoryModel {
  final int id;
  final String name;
  // final String nameAr;
  final String? description;
  // final String? descriptionAr;
  final String? image;
  final List<ProductModel> products;
  final List<SubCategoryModel> subCategories;

  CategoryModel({
    required this.id,
    required this.name,
    // required this.nameAr,
    this.description,
    // this.descriptionAr,
    this.image,
    required this.products,
    required this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      // nameAr: json['name_Ar'],
      description: json['description'],
      // descriptionAr: json['description_Ar'],
      image: json['image'],
      products: (json['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      subCategories: (json['subCategories'] as List)
          .map((e) => SubCategoryModel.fromJson(e))
          .toList(),
    );
  }
}
