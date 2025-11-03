import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:login_app/NavigationService/navigator_key.dart';
import 'package:login_app/components/my_icon_btn.dart';
import 'package:login_app/models/food.dart';
import 'package:login_app/models/resturant.dart';
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
    for (Addons addon in food.availabelAddons) {
      if (selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
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
                  child: Container(
                    width: 180,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias, // Ensures circular clip
                    child: Image.network(
                      food.networkImagePath,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) {
                          return SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                              ),
                            ),
                          );
                        } else {
                          return child;
                        }
                      },
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.error),
                    ),
                  ),
                ),

                // Food name
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Text(
                    food.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Food Category
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Text(
                    food.foodCategory.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Text(
                    "₦${food.price.toString()}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: MyIconBtn(
                    icon: Iconsax.add,
                    onPressed: () => addToCart(food, selectedAddon, context),
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
