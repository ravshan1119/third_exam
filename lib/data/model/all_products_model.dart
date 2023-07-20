class AllProductsModel {
  List<dynamic> data;

  AllProductsModel({
    required this.data,
  });

  factory AllProductsModel.fromJson(Map<String, dynamic> json) => AllProductsModel(
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
