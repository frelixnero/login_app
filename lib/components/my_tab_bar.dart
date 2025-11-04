import 'package:flutter/material.dart';
import 'package:login_app/models/food.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;
  final int selectedIndex; // Receive selectedIndex from HomePage

  MyTabBar({
    super.key,
    required this.tabController,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      controller: tabController,
      labelPadding: EdgeInsets.zero,
      dividerColor: Colors.transparent,
      tabs:
          FoodCategory.values.asMap().entries.map((entry) {
            int index = entry.key;
            String categoryName =
                entry.value.toString().toUpperCase().split(".").last;

            bool isSelected =
                selectedIndex == index; // Use received selectedIndex

            return Tab(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  categoryName,
                  style: TextStyle(
                    decoration:
                        isSelected ? TextDecoration.none : TextDecoration.none,
                    color:
                        isSelected
                            ? Theme.of(context).colorScheme.background
                            : Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
