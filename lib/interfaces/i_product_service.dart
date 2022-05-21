import 'package:eater_app_flutter/models/featured_products_header.dart';
import 'package:eater_app_flutter/models/product_category.dart';

abstract class IProductService {
  Future<List<ProductCategory>> getCategories();

  Future<List<FeaturedProductsHeader>> getFeaturedProducts();
}
