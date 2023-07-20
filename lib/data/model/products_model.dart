class ProductsModel {
  int id;
  int categoryId;
  String name;
  int price;
  String imageUrl;

  ProductsModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json["id"] as int? ?? 0,
        categoryId: json["category_id"] as int? ?? 0,
        name: json["name"] as String? ?? "",
        price: json["price"] as int? ?? 0,
        imageUrl: json["image_url"] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "price": price,
        "image_url": imageUrl,
      };

  ProductsModel copyWith({
    int? id,
    int? categoryId,
    String? name,
    int? price,
    String? imageUrl,
  }) =>
      ProductsModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
      );
}
