import 'package:flutter/material.dart';
// Note: This assumes you have added the 'shimmer' package to your pubspec.yaml
import 'package:shimmer/shimmer.dart';

// --- Reusable Skeleton Block ---
class SkeletonBlock extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  const SkeletonBlock({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // The background color of the final component's container
    final baseColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.1);

    // The main loading animation wrapper
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: Colors.grey.withOpacity(0.05),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white, // The moving shimmer color
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}
