// import 'package:flutter/material.dart';
// import 'package:login_app/models/food.dart';

// class SizeSelectorService extends ChangeNotifier {
//   // final Food food;

//   // // get size from food item
//   late String currentSize;

//   // // constructor initializes _currentSize using the provided food
//   // SizeSelectorService(this.food) {
//   //   _currentSize = food.foodSize.pastrySize;
//   // }

//   String _currentSize(Food food) {
//     currentSize = food.foodSize.pastrySize;
//     return food.foodSize.pastrySize;
//   }

//   // // getter to fecth size
//   // void getCurrentSize(){
//   //   return _currentSize;
//   // }

//   // is current Size and Selectede
//   bool isSelected(String size, Food food) {
//     if (_currentSize(food) == size.toLowerCase()) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   // Change Size
//   void updateSize(String newSize) {
//     currentSize = newSize;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:login_app/models/food.dart';

class SizeSelectorService extends ChangeNotifier {
  String _selectedSize = "small"; // Default value

  // Method to get the current size
  String currentSize(Food food) {
    return _selectedSize;
  }

  // Check if the given size string matches the currently selected size.
  bool isSelected(String size, Food food) {
    return _selectedSize.toLowerCase() == size.toLowerCase();
  }

  // Change Size and notify listeners.
  void updateSize(String newSize, Food food) {
    if (_selectedSize != newSize) {
      _selectedSize = newSize;
      notifyListeners();
    }
  }
}
