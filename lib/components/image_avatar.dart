import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageAvatar extends StatefulWidget {
  final String imageUrl;

  const ImageAvatar({super.key, required this.imageUrl});

  @override
  ImageAvatarState createState() => ImageAvatarState();
}

class ImageAvatarState extends State<ImageAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      clipBehavior: Clip.antiAlias, // Ensures circular clip
      child: CachedNetworkImage(
        height: 30,
        width: 30,
        // <-- Using the Caching Widget
        imageUrl: widget.imageUrl,
        fit: BoxFit.cover,

        // Placeholder while loading
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primaryContainer,
              value: downloadProgress.progress,
            ),
          );
        },

        // Error handling
        errorWidget:
            (context, url, error) => const Center(
              child: Icon(Icons.broken_image, color: Colors.red, size: 40),
            ),
      ),
    );
  }
}
