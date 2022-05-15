import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class FeaturedProductsSkeleton extends StatelessWidget {
  const FeaturedProductsSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      items: 2,
      period: const Duration(seconds: 2),
      builder: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 18,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            LayoutGrid(
              columnSizes: [1.fr, 1.fr],
              rowSizes: const [auto, auto],
              rowGap: 8,
              columnGap: 8,
              children: [
                _buildProductCardSkeleton(context),
                _buildProductCardSkeleton(context),
                _buildProductCardSkeleton(context),
                _buildProductCardSkeleton(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProductCardSkeleton(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
