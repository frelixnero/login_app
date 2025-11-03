import 'package:flutter/material.dart';
import 'package:login_app/components/skeleton_block.dart';

class CategoryRowSkeleton extends StatelessWidget {
  const CategoryRowSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          4, // Show a few placeholder categories
          (index) => Padding(
            padding: EdgeInsets.only(right: index < 3 ? 10 : 0),
            child: const Column(
              children: [
                // Circle for the category icon/image
                SkeletonBlock(
                  width: 65,
                  height: 65,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                SizedBox(height: 5),
                // Line for the category title
                SkeletonBlock(width: 40, height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
