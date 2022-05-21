import 'package:eater_app_flutter/interfaces/i_cart_service.dart';
import 'package:eater_app_flutter/models/cart_item.dart';
import 'package:eater_app_flutter/models/product.dart';
import 'package:rxdart/rxdart.dart';

class CartService implements ICartService {
  final Map<String, CartItem> _items = {};

  final BehaviorSubject<Map<String, CartItem>> _itemsSubject =
      BehaviorSubject.seeded({});

  @override
  Stream<List<CartItem>> get items$ =>
      _itemsSubject.map((event) => event.values.toList());

  @override
  Stream<int> get itemCount$ => _itemsSubject.map((map) => map.length);

  @override
  Stream<num> get totalPrice$ => _itemsSubject.map((map) {
        final items = map.values;
        return items.fold(0, (previousValue, element) {
          return previousValue + (element.qty * element.product.price);
        });
      });

  @override
  Stream<CartItem?> getItem(String productId) {
    return _itemsSubject.map((map) => map[productId]).distinct();
  }

  @override
  void addItem(Product p) {
    _items[p.id] = CartItem(product: p, qty: 1);
    _itemsSubject.add(_items);
  }

  @override
  void setItemQty(String productId, int qty) {
    if (qty <= 0) {
      return removeItem(productId);
    }

    final item = _items[productId];
    if (item != null) {
      _items[productId] = item.clone(qty);
      _itemsSubject.add(_items);
    }
  }

  @override
  void removeItem(String productId) {
    _items.remove(productId);
    _itemsSubject.add(_items);
  }

  @override
  void clear() {
    _items.clear();
    _itemsSubject.add(_items);
  }
}
