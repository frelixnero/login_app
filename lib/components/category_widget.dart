import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CategoryWidget({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                  child: Image.network(
                    imageUrl,
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return SizedBox(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
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
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
