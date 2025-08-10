class ProductsEntity {
  final int id;
  final String title;
  final int price;
  final String description;
  final List<String> images;

  const ProductsEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductsEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
