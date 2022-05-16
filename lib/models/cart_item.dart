import 'package:eater_app_flutter/models/product.dart';

class CartItem {
  final Product product;
  int qty = 0;

  CartItem({required this.product, required this.qty});

  CartItem clone(int? newQty) {
    return CartItem(product: product, qty: newQty ?? qty);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          product == other.product &&
          qty == other.qty;

  @override
  int get hashCode => product.hashCode ^ qty.hashCode;
}
