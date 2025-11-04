import 'package:flutter/material.dart';
import 'package:login_app/components/category_food_tile.dart';
import 'package:login_app/components/my_tab_bar.dart';
import 'package:login_app/models/food.dart';
import 'package:login_app/models/resturant.dart';
import 'package:login_app/pages/food_page.dart';
import 'package:provider/provider.dart';

class CategoriePage extends StatefulWidget {
  final int tabIndex;
  const CategoriePage({super.key, required this.tabIndex});

  @override
  State<CategoriePage> createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // Keep a mutable copy of the selected tab index in State
  late int _tabIndex;

  @override
  void initState() {
    super.initState();
    // Validate initial index coming from the widget and keep a mutable
    // copy in state. Use 0 if the provided index is out of range.
    final categoriesCount = FoodCategory.values.length;
    final initial =
        (widget.tabIndex >= 0 && widget.tabIndex < categoriesCount)
            ? widget.tabIndex
            : 0;
    _tabIndex = initial;

    _tabController = TabController(
      length: categoriesCount,
      vsync: this,
      initialIndex: initial,
    );
    _tabController.addListener(_handleTabChange);
  }

  // handle tab changes
  void _handleTabChange() {
    if (mounted) {
      setState(() {
        _tabIndex = _tabController.index; // Update state copy of selected index
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  //   // Sort through menu by categories
  List<Food> _filterFoodByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.foodCategory == category).toList();
  }

  // return food by categorie
  List<Widget> getFoodInCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterFoodByCategory(category, fullMenu);
      return ListView.builder(
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        itemCount: categoryMenu.length,
        itemBuilder: (context, index) {
          // get individual food (use the builder's index for the list)
          final food = categoryMenu[index];

          // return food tile
          return CategoryFoodTile(
            food: food,
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodPage(food: food)),
                ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: Theme.of(context).colorScheme.surface,
                centerTitle: true,
                title: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Sora-SemiBold",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(48.0),
                  child: MyTabBar(
                    tabController: _tabController,
                    selectedIndex: _tabIndex,
                  ),
                ),
              ),
            ],
        body: Consumer<Resturant>(
          builder:
              (context, rseturant, child) => TabBarView(
                controller: _tabController,
                children: getFoodInCategory(rseturant.menu),
              ),
        ),
      ),
    );
  }
}
