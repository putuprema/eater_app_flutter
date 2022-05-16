import 'package:eater_app_flutter/models/cart_item.dart';
import 'package:eater_app_flutter/models/product.dart';
import 'package:rxdart/rxdart.dart';

class CartService {
  final Map<String, CartItem> _items = {};

  final BehaviorSubject<Map<String, CartItem>> _itemsSubject =
      BehaviorSubject.seeded({});

  Stream<CartItem?> getItem(String productId) {
    return _itemsSubject.map((map) => map[productId]).distinct();
  }

  void addItem(Product p) {
    _items[p.id] = CartItem(product: p, qty: 1);
    _itemsSubject.add(_items);
  }

  void setItemQty(String productId, int qty) {
    final item = _items[productId];
    if (item != null) {
      _items[productId] = item.clone(qty);
      _itemsSubject.add(_items);
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    _itemsSubject.add(_items);
  }
}
