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
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      clipBehavior: Clip.antiAlias, // Ensures circular clip
      child: Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          } else {
            return child;
          }
        },
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    );
  }
}
