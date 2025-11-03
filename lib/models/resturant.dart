import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_app/models/cart_item.dart';
import 'food.dart';

class Resturant extends ChangeNotifier {
  final List<Food> _menu = [
    // PUFF PASTERIES
    Food(
      name: 'Cream cheese Tart',
      description:
          'With layers of flaky pastry, cream cheese, and vibrant fresh berries, they are perfect for a simple family breakfast or part of a brunch spread',
      networkImagePath:
          'https://www.spatuladesserts.com/wp-content/uploads/2024/03/Cream-Cheese-Puff-Pastry-Danish-00558.jpg',
      price: 5000,
      foodCategory: FoodCategory.puff,
      availabelAddons: [Addons(name: 'Extra Cheese', price: 1000)],
      foodSize: FoodSize(pastrySize: "small"),
    ),

    // FLAKY PASTERIES
    Food(
      name: 'Fruit Custard Tart',
      description:
          'With layers of flaky pastry, cream cheese, and vibrant fresh berries, they are perfect for a simple family breakfast or part of a brunch spread',
      networkImagePath:
          'https://grabyourspork.com/wp-content/uploads/2016/01/Fruit-and-Custard-Tart-007.jpg',
      price: 5000,
      foodCategory: FoodCategory.flaky,
      availabelAddons: [Addons(name: 'Extra Cheese', price: 1000)],
      foodSize: FoodSize(pastrySize: "small"),
    ),

    // SHORTCRUST PASTERIES
    Food(
      name: 'Sweetheart Raspberry Tart',
      description:
          'With layers of flaky pastry, cream cheese, and vibrant fresh berries, they are perfect for a simple family breakfast or part of a brunch spread',
      networkImagePath:
          'https://www.jusrol.co.uk/wp-content/uploads/2022/02/Sweetheart-Raspberry-Recipe-Card.jpg',
      price: 5000,
      foodCategory: FoodCategory.shortcrust,
      availabelAddons: [Addons(name: 'Extra Cheese', price: 1000)],
      foodSize: FoodSize(pastrySize: "small"),
    ),

    // CHOUX PASTERIES
    Food(
      name: 'Cream Puff Choux',
      description:
          'With layers of flaky pastry, cream cheese, and vibrant fresh berries, they are perfect for a simple family breakfast or part of a brunch spread',
      networkImagePath:
          'https://sallysbakingaddiction.com/wp-content/uploads/2018/08/cream-puffs-2.jpg',
      price: 5000,
      foodCategory: FoodCategory.choux,
      availabelAddons: [Addons(name: 'Extra Cheese', price: 1000)],
      foodSize: FoodSize(pastrySize: "small"),
    ),

    // FILO PASTERIES
    Food(
      name: 'Chocolate Baklava Bark',
      description:
          'Baklava is a Middle Eastern/Mediterranean dessert made by layering filo dough with grounded nuts and spices, then soaking it with sweet syrup',
      networkImagePath:
          'https://bromabakery.com/wp-content/uploads/2018/09/Chocolate-Hazelnut-Baklava-6-225x225.jpg',
      price: 5000,
      foodCategory: FoodCategory.filo,
      availabelAddons: [Addons(name: 'Extra Cheese', price: 1000)],
      foodSize: FoodSize(pastrySize: "small"),
    ),
  ];

  // delivery address he user can
  String _deliveryAddress = "";

  // GETTERS
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  // OPERATIONS
  // create cart
  final List<CartItem> _cart = [];

  // ad to cart
  void addToCart(Food food, List<Addons> selectedAddons) {
    // check if there is acart item with the same food quantity
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if food items are the same
      bool isSameFood = item.food == food;

      // check if list of selected addons are the same
      bool issameAddon = ListEquality().equals(
        item.selectedAddons,
        selectedAddons,
      );
      return isSameFood && issameAddon;
    });

    // if item exist increase its quantity
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
    }
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addons addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  // get total number of items incart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void updateAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  // HELPERS
  // generate receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();

    receipt.writeln("Here's your receipt");
    receipt.writeln();

    // format date to seconds only
    String formattedDate = DateFormat(
      "yyyy-MM-dd HH:mm:ss",
    ).format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("----------");

    for (final cartItem in cart) {
      receipt.writeln(
        "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}",
      );

      if (cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln(
          "   Add-ons: ${_formatListOfAddons(cartItem.selectedAddons)}",
        );
      }
      receipt.writeln();
    }
    receipt.writeln("---------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Deliverying to : $deliveryAddress");
    receipt.writeln();
    // receipt.writeln();
    // receipt.writeln("OrderId: ${generateReference()}");

    print(receipt);

    return receipt.toString();
  }

  // format double value into money
  String _formatPrice(double price) {
    return "₦ ${price.toStringAsFixed(2)}";
  }

  // format list of addonds into string summary
  String _formatListOfAddons(List<Addons> addons) {
    return addons
        .map((addon) => "${addon.name}  (${_formatPrice(addon.price)})")
        .join(",");
  }

  // String generateReference() {
  //   String orderRef =
  //       "${AuthService().getCurrentUser()!.uid}_${DateTime.now().millisecondsSinceEpoch}";
  //   return orderRef;
  // }

  // Modified Resturant functions
  String getOrderForDb(List cart) {
    List<String> orderDetails =
        cart.map((cartItem) {
          return "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}";
        }).toList();
    return orderDetails.join(" | ");
  }

  String getAddons(List cart) {
    List<String> allAddons =
        cart
            .where((cartItem) => cartItem.selectedAddons.isNotEmpty)
            .map((cartItem) => _formatListOfAddons(cartItem.selectedAddons))
            .toList();

    return allAddons.isNotEmpty ? allAddons.join(", ") : "No Addons";
  }
}
