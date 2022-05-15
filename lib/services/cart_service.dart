import 'package:eater_app_flutter/models/cart_item.dart';
import 'package:eater_app_flutter/models/product.dart';
import 'package:rxdart/rxdart.dart';

class CartService {
  final BehaviorSubject<CartItem?> _cartItemEvent =
      BehaviorSubject.seeded(null);

  final Map<String, CartItem> _items = {};

  Stream<CartItem?> getItem(String productId) {
    _cartItemEvent.add(_items[productId]);
    return _cartItemEvent.where((event) => event?.id == productId);
  }

  void addItem(Product p) {
    final cartItem = CartItem(p: p, qty: 1);
    _items[p.id] = cartItem;

    _cartItemEvent.add(cartItem);
  }

  void setItemQty(String productId, int qty) {
    final cartItem = _items[productId];

    if (cartItem != null) {
      cartItem.qty = qty;
      _cartItemEvent.add(cartItem);
    }
  }

  void removeItem(String productId) {
    final cartItem = _items[productId];

    if (cartItem != null) {
      _items.remove(productId);

      cartItem.qty = 0;
      _cartItemEvent.add(cartItem);
    }
  }
}
