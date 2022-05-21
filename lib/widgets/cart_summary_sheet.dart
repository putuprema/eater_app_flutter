import 'package:eater_app_flutter/interfaces/i_cart_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class CartSummarySheet extends StatelessWidget {
  final num totalPrice;

  CartSummarySheet({super.key, required this.totalPrice});

  final _currencyFormatter = NumberFormat.simpleCurrency(
    locale: "id_ID",
    decimalDigits: 0,
  );
  final _cartService = GetIt.I<ICartService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _currencyFormatter.format(totalPrice),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Thank you!"),
                ),
              );
              Navigator.pop(context);
              _cartService.clear();
            },
            child: const Text("Checkout"),
          )
        ],
      ),
    );
  }
}
