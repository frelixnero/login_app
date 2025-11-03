import 'package:flutter/material.dart';
import 'package:login_app/components/skeleton_block.dart';

class GridSkeleton extends StatelessWidget {
  const GridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7, // Adjust to match the aspect ratio of MyFoodTile
      ),
      itemCount: 4, // Show a fixed number of skeleton items
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skeleton for the Image Thumbnail
            const SkeletonBlock(width: double.infinity, height: 120),
            const SizedBox(height: 8),
            // Line for the Title
            SkeletonBlock(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 12,
            ),
            const SizedBox(height: 4),
            // Line for the Subtitle/Price
            SkeletonBlock(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
