class Product {
  final String id;
  final String name;
  final String description;
  final num price;
  final String imageUrl;
  final bool enabled;

  const Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.enabled});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        imageUrl: json['imageUrl'],
        enabled: json['enabled']);
  }
}
