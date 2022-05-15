import 'dart:convert';

import 'package:eater_app_flutter/models/featured_products_header.dart';
import 'package:eater_app_flutter/models/product_category.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<ProductCategory>> getCategories() async {
    await Future.delayed(const Duration(seconds: 2));

    final response = await http.get(
      Uri.parse('https://eaterapigwap01.azure-api.net/v1/category'),
    );

    List<dynamic> responseArray = jsonDecode(response.body);
    return responseArray.map((e) => ProductCategory.fromJson(e)).toList();
  }

  Future<List<FeaturedProductsHeader>> getFeaturedProducts() async {
    await Future.delayed(const Duration(seconds: 2));

    final response = await http.get(
      Uri.parse('https://eaterapigwap01.azure-api.net/v1/products/featured'),
    );

    List<dynamic> responseArray = jsonDecode(response.body);
    return responseArray
        .map((e) => FeaturedProductsHeader.fromJson(e))
        .toList();
  }
}
