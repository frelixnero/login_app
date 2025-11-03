import 'package:flutter/material.dart';
import 'package:login_app/components/food_quantity_selector.dart';
import 'package:login_app/models/cart_item.dart';
import 'package:login_app/models/resturant.dart';
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
                    child: Image.network(
                      cartItem.food.networkImagePath,
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
                        "₦${cartItem.food.price.toString()}0",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                // Quantity Selector
                MyQuantitySelector(
                  food: cartItem.food,
                  quantity: cartItem.quantity,
                  onIncrement: () {
                    resturant.addToCart(cartItem.food, cartItem.selectedAddons);
                  },
                  onDecrement: () {
                    resturant.removeFromCart(cartItem);
                  },
                ),
              ],
            ),
          ),
    );
  }
}
