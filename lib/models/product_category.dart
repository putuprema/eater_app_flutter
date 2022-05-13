class ProductCategory {
  final String id;
  final String name;
  final num? sortIndex;

  const ProductCategory({required this.id, required this.name, this.sortIndex});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
        id: json['id'], name: json['name'], sortIndex: json['sortIndex']);
  }
}
