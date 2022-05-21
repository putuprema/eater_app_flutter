import 'package:eater_app_flutter/models/product.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CartItemCard extends StatelessWidget {
  final Product product;
  final int qty;
  final void Function(Product product, int qty) onItemQtyChanged;

  CartItemCard(
      {Key? key,
      required this.product,
      required this.qty,
      required this.onItemQtyChanged})
      : super(key: key);

  final _currencyFormatter = NumberFormat.simpleCurrency(
    locale: "id_ID",
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
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
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: _currencyFormatter.format(product.price),
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: " x $qty",
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () => onItemQtyChanged(product, qty + 1),
                    style: OutlinedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: const Size.fromHeight(32),
                    ),
                    child: const Text("+"),
                  ),
                  const SizedBox(height: 4),
                  OutlinedButton(
                    onPressed: () => onItemQtyChanged(product, qty - 1),
                    style: OutlinedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: const Size.fromHeight(32),
                    ),
                    child: const Text("-"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
