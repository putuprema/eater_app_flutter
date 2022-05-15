import 'package:eater_app_flutter/models/cart_item.dart';
import 'package:eater_app_flutter/models/product.dart';
import 'package:eater_app_flutter/services/cart_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailSheet extends StatelessWidget {
  final _cartService = GetIt.I.get<CartService>();
  final _currencyFormatter = NumberFormat.simpleCurrency(
    locale: "id_ID",
    decimalDigits: 0,
  );

  final Product product;

  ProductDetailSheet({
    super.key,
    required this.product,
  });

  void setItemQty(int qty) {
    _cartService.setItemQty(product.id, qty);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 240,
            height: 240,
            child: ExtendedImage.network(
              product.imageUrl,
              fit: BoxFit.cover,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              loadStateChanged: (state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.white,
                      child: Expanded(
                        child: Container(
                          color: Colors.grey[300]!,
                        ),
                      ),
                    );
                  default:
                    break;
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            product.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _currencyFormatter.format(product.price),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: _cartService.getItem(product.id),
            builder: (_, AsyncSnapshot<CartItem?> snapshot) {
              final itemInCart = snapshot.data;
              final existInCart = itemInCart != null && itemInCart.qty > 0;

              if (existInCart) {
                return Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () => setItemQty(itemInCart.qty - 1),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "-",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        '${itemInCart.qty}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () => setItemQty(itemInCart.qty + 1),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("+"),
                      ),
                    ),
                  ],
                );
              }

              return ElevatedButton(
                onPressed: () {
                  _cartService.addItem(product);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("ADD +"),
              );
            },
          ),
        ],
      ),
    );
  }
}
