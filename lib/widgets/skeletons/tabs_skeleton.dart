import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class TabsSkeleton extends StatelessWidget {
  const TabsSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonGridLoader(
      items: 5,
      itemsPerRow: 5,
      period: const Duration(seconds: 2),
      direction: SkeletonDirection.ltr,
      childAspectRatio: 2,
      builder: Container(
        padding: const EdgeInsets.only(left: 0, right: 0, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
