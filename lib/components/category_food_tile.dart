import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:login_app/models/food.dart';

class CategoryFoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;

  CategoryFoodTile({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // food details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Sora-SemiBold",
                        ),
                      ),
                      Text(
                        food.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Sora-SemiBold",
                        ),
                      ),
                      SizedBox(height: 11),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          "\$${food.price.toString()}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // food image
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(12),
                //   child: Image.asset(food.imagePath, height: 120),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        width: 5,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias, // Ensures circular clip
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        // <-- Using the Caching Widget
                        imageUrl: food.networkImagePath,
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
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
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
                ),
              ],
            ),
          ),
        ),
        Divider(color: Theme.of(context).colorScheme.primary),
      ],
    );
  }
}
