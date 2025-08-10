import '../../domain/entities/products_entity.dart';

class MainProductResponseModel {
  final List<ProductListingResponseModel> products;

  MainProductResponseModel({required this.products});

  factory MainProductResponseModel.fromJson(dynamic json) {
    final rawList = json['data'] as List<dynamic>? ?? [];
    if (json is List) {
      return MainProductResponseModel(
        products: rawList
            .map((e) => ProductListingResponseModel.fromJson(e))
            .toList(),
      );
    } else {
      throw Exception("Unexpected JSON format: not a List");
    }
  }
}

class ProductListingResponseModel extends ProductsEntity {
  const ProductListingResponseModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.images,
  });

  factory ProductListingResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductListingResponseModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
      "images": images
    };
  }
}
