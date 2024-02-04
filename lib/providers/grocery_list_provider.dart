import 'package:flutter/material.dart';
import 'package:transport4_demo_app/models/grocery_model.dart';

class GroceryListProvider extends ChangeNotifier {
  final List<Grocery> _groceryList = [];
  List<Grocery> get groceryList => _groceryList;

  addGrocery({required Grocery grocery}) {
    _groceryList.add(grocery);
    notifyListeners();
  }

  removeItem({required int index}) {
    groceryList.removeAt(index);
    notifyListeners();
  }
}
