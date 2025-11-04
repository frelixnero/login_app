import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final void Function()? onTap;

  const CategoryWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 7.0,
          shadowColor: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.onTertiary,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      height: 30,
                      width: 30,
                      // <-- Using the Caching Widget
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,

                      // Placeholder while loading
                      progressIndicatorBuilder: (
                        context,
                        url,
                        downloadProgress,
                      ) {
                        return Center(
                          child: CircularProgressIndicator(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            value: downloadProgress.progress,
                          ),
                        );
                      },

                      // Error handling
                      errorWidget:
                          (context, url, error) => const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 8.24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
