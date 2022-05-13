import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    'https://assets.epicurious.com/photos/5bd36153a1f98842aefee324/6:4/w_1600,c_limit/Large-Format-Turkey-11102018.jpg',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SkeletonGridLoader(
                        items: 1,
                        itemsPerRow: 1,
                        builder: Container(
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Nasi Goreng Ayam",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Rp 40.000",
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("ADD +"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
