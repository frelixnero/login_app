import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:login_app/NavigationService/navigator_key.dart';
import 'package:login_app/components/my_icon_btn.dart';
import 'package:login_app/models/food.dart';
import 'package:login_app/models/resturant.dart';
import 'package:login_app/util/responsive.dart';
import 'package:provider/provider.dart';

class MyFoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;
  MyFoodTile({super.key, required this.food, required this.onTap});

  final Map<Addons, bool> selectedAddon = {};

  // method to add to cart
  void addToCart(
    Food food,
    Map<Addons, bool> selectedAddons,
    BuildContext context,
  ) {
    List<Addons> currentlySelectedAddons = [];
    // Safety check: only add if the food has addons and the map contains them
    if (food.availabelAddons.isNotEmpty && selectedAddons.isNotEmpty) {
      for (Addons addon in food.availabelAddons) {
        if (selectedAddons[addon] == true) {
          currentlySelectedAddons.add(addon);
        }
      }
    }
    print("Text is large: ${Responsive().isTextLarge(context)}");
    print("Text is medium: ${Responsive().isTextMedium(context)}");
    print("T E X T  S C A L E R:${MediaQuery.of(context).textScaleFactor}");

    // Use the root navigator context for the SnackBar
    if (NavigationService.navigatorKey.currentState != null) {
      context.read<Resturant>().addToCart(food, currentlySelectedAddons);
      ScaffoldMessenger.of(
        NavigationService.navigatorKey.currentState!.context,
      ).showSnackBar(
        const SnackBar(
          content: Text("Added To Cart"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsiveProvider = Provider.of<Responsive>(context);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          // Important: MainAxisSize.min ensures the column only takes the
          // height needed for its children, respecting the GridView's height calculation.
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  // --- FIX: Replace fixed size Container with AspectRatio ---
                  child: AspectRatio(
                    aspectRatio:
                        1.3, // Defines the image shape (slightly wider than tall)
                    child: Container(
                      // We no longer need width: 180 or height: 120 here!
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
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
                // --- END FIX ---

                // Food name
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Text(
                    food.name.toUpperCase(),
                    // --- SAFETY FIX: Restrict Name lines under large font ---
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    // --- END SAFETY FIX ---
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Sora-SemiBold",
                    ),
                  ),
                ),
                // Food Category
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Text(
                    food.foodCategory.name.toUpperCase(),
                    maxLines: 1, // Restrict Category to one line
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
            responsiveProvider.isTextEnormousAndLarge(context)
                ? responsiveProvider.isShorterThanNormal(context)
                    ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                              right: 10,
                            ),
                            child: Text(
                              "\$ ${food.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Sora-SemiBold",
                                fontWeight: FontWeight.w500,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                              bottom: 10,
                              right: 10,
                            ),
                            child: MyIconBtn(
                              icon: Iconsax.add,
                              onPressed:
                                  () => addToCart(food, selectedAddon, context),
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ],
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 10,
                            right: 10,
                          ),
                          child: Text(
                            "\$ ${food.price.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Sora-SemiBold",
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 10,
                            bottom: 10,
                            right: 10,
                          ),
                          child: MyIconBtn(
                            icon: Iconsax.add,
                            onPressed:
                                () => addToCart(food, selectedAddon, context),
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ],
                    )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 10,
                        right: 10,
                      ),
                      child: Text(
                        "\$ ${food.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Sora-SemiBold",
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 10,
                        bottom: 10,
                        right: 10,
                      ),
                      child: MyIconBtn(
                        icon: Iconsax.add,
                        onPressed:
                            () => addToCart(food, selectedAddon, context),
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
