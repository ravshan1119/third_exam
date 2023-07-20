class ProductModelFields {
  static const String id = "_id";
  static const String categoryId = "category";
  static const String name = "name";
  static const String price = "price";
  static const String imageUrl = "image_url";

  static const String productsTable = "products_table";
  static const String savedProductTable = "saved_products";
}

class ProductsModelSql {
  int id;
  int categoryId;
  String name;
  int price;
  String imageUrl;

  ProductsModelSql({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory ProductsModelSql.fromJson(Map<String, dynamic> json) => ProductsModelSql(
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

  ProductsModelSql copyWith({
    int? id,
    int? categoryId,
    String? name,
    int? price,
    String? imageUrl,
  }) =>
      ProductsModelSql(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
      );
}
