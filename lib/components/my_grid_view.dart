import 'package:flutter/material.dart';
import 'package:login_app/components/my_food_tile.dart';
import 'package:login_app/models/food.dart';
import 'package:login_app/models/resturant.dart';
import 'package:login_app/pages/food_page.dart';
import 'package:provider/provider.dart';

class MyGridView extends StatelessWidget {
  // New property to control whether navigation is permitted from this grid view instance.
  final bool allowNavigation;

  const MyGridView({
    super.key,
    // Set a default value of true for typical usage on the home page.
    this.allowNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    // Resturant instance to get the menu items
    Resturant myResturant = Provider.of<Resturant>(context, listen: false);
    List<Food> foodItems = myResturant.menu;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.68,
      ),
      itemCount: foodItems.length,
      itemBuilder: (BuildContext context, int index) {
        return MyFoodTile(
          food: foodItems[index],

          onTap: () {
            if (allowNavigation) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodPage(food: foodItems[index]),
                ),
              );
            }
          },
        );
      },
    );
  }
}
