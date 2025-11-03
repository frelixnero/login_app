import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyFoodTileSkeleton extends StatelessWidget {
  const MyFoodTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: const EdgeInsets.all(8.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skeleton for the Image
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white, // The gray area itself
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 8),

            // Skeleton for the Title (Long Line)
            Container(height: 14, width: 150, color: Colors.white),
            const SizedBox(height: 6),

            // Skeleton for the Price (Short Line)
            Container(height: 10, width: 80, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
