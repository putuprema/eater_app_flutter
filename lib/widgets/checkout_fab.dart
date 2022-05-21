import 'dart:async';

import 'package:badges/badges.dart';
import 'package:eater_app_flutter/interfaces/i_cart_service.dart';
import 'package:eater_app_flutter/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class CheckoutFab extends StatefulWidget {
  const CheckoutFab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CheckoutFabState();
}

class _CheckoutFabState extends State<CheckoutFab>
    with SingleTickerProviderStateMixin {
  final _currencyFormatter = NumberFormat.simpleCurrency(
    locale: "id_ID",
    decimalDigits: 0,
  );
  final _cartService = GetIt.I.get<ICartService>();

  late StreamSubscription _itemCountSubscription;
  late StreamSubscription _totalPriceSubscription;

  late AnimationController _animationController;
  late Animation<double> _animation;

  int _itemCount = 0;
  num _totalPrice = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 1.1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuart,
      ),
    )..addListener(() {
        setState(() {});
      });

    _itemCountSubscription = _cartService.itemCount$.listen((itemCount) {
      setState(() {
        _itemCount = itemCount;
      });

      if (itemCount == 0) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });

    _totalPriceSubscription = _cartService.totalPrice$.listen((totalPrice) {
      setState(() {
        _totalPrice = totalPrice;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: Offset(_animation.value, 0.0),
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          elevation: 10,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Badge(
              toAnimate: false,
              badgeColor: Colors.blue,
              badgeContent: Text(
                _itemCount.toString(),
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              child: const Icon(Icons.shopping_cart),
            ),
            const SizedBox(width: 16),
            const Text("Checkout"),
            const SizedBox(width: 4),
            Text(
              "(${_currencyFormatter.format(_totalPrice)})",
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _itemCountSubscription.cancel();
    _totalPriceSubscription.cancel();
    super.dispose();
  }
}
