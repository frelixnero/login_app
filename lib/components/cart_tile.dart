import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:login_app/components/food_quantity_selector.dart';
import 'package:login_app/models/cart_item.dart';
import 'package:login_app/models/resturant.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Resturant>(
      builder:
          (context, resturant, child) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Food Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      // <-- Using the Caching Widget
                      imageUrl: cartItem.food.networkImagePath,
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
                const SizedBox(width: 8),
                // Food Name & Price
                Expanded(
                  // Wrap the Column with Expanded
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.food.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "\$${cartItem.food.price.toString()}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                // Quantity Selector
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 2),
                      child: GestureDetector(
                        onTap: () {
                          resturant.removeFromCart(cartItem);
                        },
                        child: Icon(LucideIcons.trash, color: Colors.red),
                      ),
                    ),
                    MyQuantitySelector(
                      food: cartItem.food,
                      quantity: cartItem.quantity,
                      onIncrement: () {
                        resturant.addToCart(
                          cartItem.food,
                          cartItem.selectedAddons,
                        );
                      },
                      onDecrement: () {
                        resturant.removeFromCart(cartItem);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
