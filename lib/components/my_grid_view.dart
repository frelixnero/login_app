import 'package:flutter/material.dart';
import 'package:login_app/components/my_food_tile.dart';
import 'package:login_app/models/food.dart';
import 'package:login_app/models/resturant.dart';
import 'package:login_app/pages/food_page.dart';
import 'package:login_app/util/responsive.dart';
import 'package:provider/provider.dart';

class MyGridView extends StatelessWidget {
  final bool allowNavigation;
  final Food? excludeFood;

  const MyGridView({super.key, this.allowNavigation = true, this.excludeFood});

  @override
  Widget build(BuildContext context) {
    final Resturant myResturant = Provider.of<Resturant>(
      context,
      listen: false,
    );
    List<Food> foodItems = myResturant.menu;

    // Filter out the excluded food if provided
    if (excludeFood != null) {
      foodItems =
          foodItems.where((food) => food.name != excludeFood!.name).toList();
    }
    final responsiveProvider = Provider.of<Responsive>(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: responsiveProvider.isTablet(context) ? 4 : 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio:
            responsiveProvider.isLongerThanNormal(context) ? 0.60 : 0.68,
      ),
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
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
