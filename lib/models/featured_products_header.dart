import 'package:eater_app_flutter/models/product.dart';
import 'package:eater_app_flutter/models/product_category.dart';

class FeaturedProductsHeader {
  final ProductCategory category;
  final List<Product> products;

  const FeaturedProductsHeader(
      {required this.category, required this.products});

  factory FeaturedProductsHeader.fromJson(Map<String, dynamic> json) {
    return FeaturedProductsHeader(
        category: json['category'], products: json['products']);
  }
}
