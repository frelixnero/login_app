import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:login_app/NavigationService/navigator_key.dart';
import 'package:login_app/components/food_page_carousel.dart';
import 'package:login_app/components/my_grid_view.dart';
import 'package:login_app/components/my_icon_btn.dart';
import 'package:login_app/components/reflex_btn.dart';
import 'package:login_app/components/size_selector.dart';
import 'package:login_app/models/food.dart';
import 'package:login_app/models/resturant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  const FoodPage({super.key, required this.food});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final Map<Addons, bool> selectedAddon = {};

  @override
  void initState() {
    super.initState();
    for (Addons addon in widget.food.availabelAddons) {
      selectedAddon[addon] = false;
    }
  }

  double quantitySelector = 1.0;

  void increaseQuantity() {
    setState(() {
      quantitySelector += 1;
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (quantitySelector > 1) {
        quantitySelector -= 1;
      }
    });
  }

  // method to add to cart
  void addToCart(Food food, Map<Addons, bool> selectedAddons) {
    List<Addons> currentlySelectedAddons = [];
    for (Addons addon in widget.food.availabelAddons) {
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
    // Resturant myResturant = Provider.of<Resturant>(context, listen: false);
    // final userCart = myResturant.cart;
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                // Food Page Carousel
                SizedBox(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: FoodPageCarousel(
                      imageUrl1:
                          "https://www.bhg.com/thmb/7dROILyl6Q6ZtiKBbe8B_CgC_II=/2250x0/filters:no_upscale():strip_icc()/Lady-Locks-Recipe-6750995-fece434185e547f985ecb87ef4444e48.jpg",
                      imageUrl2:
                          "https://www.spatuladesserts.com/wp-content/uploads/2024/03/Chocolate-Puff-Pastry-00438.jpg",
                      imageUrl3:
                          "https://tastewise.io/wp-content/uploads/2025/06/Blog-image-Pastry-trends.png",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Quantity Selector
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.food.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '₦${widget.food.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyIconBtn(
                            icon: Icons.add,
                            onPressed: () => increaseQuantity(),
                            height: 40,
                            width: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, right: 4),
                            child: Text(
                              "${quantitySelector.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.tertiary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          MyIconBtn(
                            icon: Icons.remove,
                            onPressed: () => decreaseQuantity(),
                            height: 40,
                            width: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      // food description
                      Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Text(
                          '${widget.food.description}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Size Selector
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Select Size',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizeSelector(food: widget.food),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'More Like this',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'See more',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                              fontSize: 15,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                            ),
                          ),
                        ],
                      ),
                      MyGridView(allowNavigation: false),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            child: ReflexButton(
              onTap: () => addToCart(widget.food, selectedAddon),
              title: "Add to Cart",
              btnIcon: Iconsax.shopping_cart,
            ),
          ),
        ],
      ),
    );
  }
}
