import 'package:eater_app_flutter/models/product.dart';

class CartItem extends Product {
  int qty = 0;

  CartItem({required Product p, required this.qty})
      : super(
          id: p.id,
          description: p.description,
          enabled: p.enabled,
          imageUrl: p.imageUrl,
          name: p.name,
          price: p.price,
        );
}
