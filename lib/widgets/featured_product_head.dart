import 'package:eater_app_flutter/models/featured_products_header.dart';
import 'package:eater_app_flutter/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class FeaturedProductHead extends StatefulWidget {
  const FeaturedProductHead({Key? key, required this.data}) : super(key: key);

  final FeaturedProductsHeader data;

  @override
  State<StatefulWidget> createState() => _FeaturedProductHeadState();
}

class _FeaturedProductHeadState extends State<FeaturedProductHead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18, bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.category.name,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          LayoutGrid(
            columnSizes: [1.fr, 1.fr],
            rowSizes: List.generate(
              (widget.data.products.length / 2).round(),
              (_) => auto,
            ),
            rowGap: 8,
            columnGap: 8,
            children:
                widget.data.products.map((e) => ProductCard(data: e)).toList(),
          )
        ],
      ),
    );
  }
}
