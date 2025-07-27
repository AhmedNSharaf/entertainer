class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final int placeId;
  final String offerTitle;
  final String offerType;
  final DateTime offerValidUntil;
  final int categoryId;
  final int subCategoryId;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.placeId,
    required this.offerTitle,
    required this.offerType,
    required this.offerValidUntil,
    required this.categoryId,
    required this.subCategoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      placeId: json['placeId'],
      offerTitle: json['offerTitle'],
      offerType: json['offerType'],
      offerValidUntil: DateTime.parse(json['offerValidUntil']),
      categoryId: json['categoryId'],
      subCategoryId: json['subCategoryId'],
    );
  }
}
