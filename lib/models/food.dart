class Food {
  final String name;
  final String description;
  final String networkImagePath;
  final double price;
  final FoodCategory foodCategory;
  List<Addons> availabelAddons;
  final FoodSize foodSize;

  Food({
    required this.name,
    required this.description,
    required this.networkImagePath,
    required this.price,
    required this.foodCategory,
    required this.availabelAddons,
    required this.foodSize,
  });
}

// Food Category
enum FoodCategory { puff, flaky, shortcrust, choux, filo }

// Size
class FoodSize {
  String pastrySize = "small";

  FoodSize({required this.pastrySize});
}

// food addons
class Addons {
  String name;
  double price;

  Addons({required this.name, required this.price});
}
