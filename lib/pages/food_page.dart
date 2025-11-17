import 'package:flutter/material.dart';
import 'package:login_app/NavigationService/navigator_key.dart';
import 'package:login_app/components/food_page_carousel.dart';
import 'package:login_app/components/my_grid_view.dart';
import 'package:login_app/components/my_icon_btn.dart';
import 'package:login_app/components/reflex_btn.dart';
import 'package:login_app/components/size_selector.dart';
import 'package:login_app/models/food.dart';
import 'package:login_app/models/resturant.dart';
import 'package:login_app/util/responsive.dart';
import 'package:lucide_icons/lucide_icons.dart';
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
    // Start fetching the data when the widget is created

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
    final responsiveProvider = Provider.of<Responsive>(context);
    // Resturant myResturant = Provider.of<Resturant>(context, listen: false);
    // final userCart = myResturant.cart;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Product Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Sora-SemiBold",
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                // Food Page Carousel
                SizedBox(
                  height: 265,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: FoodPageCarousel(
                      imageUrl1: widget.food.networkImagePath,
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
                  child:
                      responsiveProvider.isTextEnormousAndLarge(context)
                          ? responsiveProvider.isShorterThanNormal(context)
                              ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.food.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.onSecondary,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Sora-SemiBold",
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '\$${widget.food.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.onSecondary,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Sora-SemiBold",
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        MyIconBtn(
                                          icon: Icons.add,
                                          onPressed: () => increaseQuantity(),
                                          height: 40,
                                          width: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 4,
                                            right: 4,
                                          ),
                                          child: Text(
                                            "${quantitySelector.toStringAsFixed(0)}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.tertiary,
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
                              )
                              : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.food.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onSecondary,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Sora-SemiBold",
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '\$${widget.food.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onSecondary,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Sora-SemiBold",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10),
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
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                          right: 4,
                                        ),
                                        child: Text(
                                          "${quantitySelector.toStringAsFixed(0)}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.tertiary,
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
                              )
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.food.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Sora-SemiBold",
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '\$${widget.food.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Sora-SemiBold",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
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
                                    padding: const EdgeInsets.only(
                                      left: 4,
                                      right: 4,
                                    ),
                                    child: Text(
                                      "${quantitySelector.toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.tertiary,
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
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Sora-SemiBold",
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
                            fontWeight: FontWeight.w400,
                            fontFamily: "Sora-Regular",
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
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Sora-SemiBold",
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
                            'Similar Pastries',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Sora-SemiBold",
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
                      MyGridView(
                        allowNavigation: true,
                        excludeFood: widget.food,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: ReflexButton(
              onTap: () => addToCart(widget.food, selectedAddon),
              title: "Add to Cart",
              btnIcon: LucideIcons.shoppingCart,
            ),
          ),
        ],
      ),
    );
  }
}
