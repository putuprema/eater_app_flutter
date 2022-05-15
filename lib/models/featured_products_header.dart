import 'package:eater_app_flutter/models/product.dart';
import 'package:eater_app_flutter/models/product_category.dart';

class FeaturedProductsHeader {
  final ProductCategory category;
  final List<Product> products;

  const FeaturedProductsHeader(
      {required this.category, required this.products});

  factory FeaturedProductsHeader.fromJson(Map<String, dynamic> json) {
    List<dynamic> productsJson = json['products'];

    return FeaturedProductsHeader(
      category: ProductCategory.fromJson(json['category']),
      products: productsJson.map((e) => Product.fromJson(e)).toList(),
    );
  }
}
