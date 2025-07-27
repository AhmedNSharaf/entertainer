class SubCategoryModel {
  final int id;
  final String name;
  final String? description;
  final String? image;
  final int categoryId;

  SubCategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.categoryId,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      categoryId: json['categoryId'],
    );
  }
}
