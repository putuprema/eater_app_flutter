import 'package:eater_app_flutter/interfaces/i_cart_service.dart';
import 'package:eater_app_flutter/models/cart_item.dart';
import 'package:eater_app_flutter/models/product.dart';
import 'package:eater_app_flutter/widgets/cart_item_card.dart';
import 'package:eater_app_flutter/widgets/cart_summary_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _cartService = GetIt.I<ICartService>();

  void _onItemQtyChanged(Product product, int qty) {
    _cartService.setItemQty(product.id, qty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _cartService.items$,
        builder: (_, AsyncSnapshot<List<CartItem>> snapshot) {
          final cartItems = snapshot.data;

          if (cartItems == null || cartItems.isEmpty) {
            return const Center(
              child: Text("There are no items in cart!"),
            );
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) => CartItemCard(
              product: cartItems[index].product,
              qty: cartItems[index].qty,
              onItemQtyChanged: _onItemQtyChanged,
            ),
            separatorBuilder: (_, index) => const SizedBox(height: 6),
            itemCount: cartItems.length,
          );
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _cartService.totalPrice$,
        builder: (_, AsyncSnapshot<num> snapshot) {
          final totalPrice = snapshot.data ?? 0;
          if (totalPrice == 0) return const SizedBox();
          return CartSummarySheet(totalPrice: totalPrice);
        },
      ),
    );
  }
}
