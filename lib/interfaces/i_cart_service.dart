import 'package:eater_app_flutter/models/cart_item.dart';
import 'package:eater_app_flutter/models/product.dart';

abstract class ICartService {
  Stream<List<CartItem>> get items$;

  Stream<int> get itemCount$;

  Stream<num> get totalPrice$;

  Stream<CartItem?> getItem(String productId);

  void addItem(Product p);

  void setItemQty(String productId, int qty);

  void removeItem(String productId);

  void clear();
}
