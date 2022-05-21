import 'dart:ui';

import 'package:eater_app_flutter/interfaces/i_cart_service.dart';
import 'package:eater_app_flutter/models/cart_item.dart';
import 'package:eater_app_flutter/models/product.dart';
import 'package:eater_app_flutter/widgets/product_detail_sheet.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key? key, required this.data}) : super(key: key);

  final Product data;

  final _cartService = GetIt.I.get<ICartService>();
  final _currencyFormatter = NumberFormat.simpleCurrency(
    locale: "id_ID",
    decimalDigits: 0,
  );

  void setItemQty(int qty) {
    _cartService.setItemQty(data.id, qty);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (_) => SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black26,
                          width: 0.25,
                        ),
                      ),
                      child: ProductDetailSheet(product: data),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1 / 1,
                child: ExtendedImage.network(
                  data.imageUrl,
                  fit: BoxFit.cover,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  loadStateChanged: (state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.white,
                          child: Container(
                            color: Colors.grey[300]!,
                          ),
                        );
                      default:
                        break;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                data.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _currencyFormatter.format(data.price),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              StreamBuilder(
                stream: _cartService.getItem(data.id),
                builder: (_, AsyncSnapshot<CartItem?> snapshot) {
                  final itemInCart = snapshot.data;
                  final existInCart = itemInCart != null && itemInCart.qty > 0;

                  if (existInCart) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: OutlinedButton(
                            onPressed: () => setItemQty(itemInCart.qty - 1),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(32),
                            ),
                            child: const Text("-"),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            '${itemInCart.qty}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: OutlinedButton(
                            onPressed: () => setItemQty(itemInCart.qty + 1),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(32),
                            ),
                            child: const Text("+"),
                          ),
                        ),
                      ],
                    );
                  }

                  return OutlinedButton(
                    onPressed: () {
                      _cartService.addItem(data);
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(32),
                    ),
                    child: const Text("ADD +"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
