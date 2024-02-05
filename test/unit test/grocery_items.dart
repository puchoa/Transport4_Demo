import 'package:transport4_demo_app/models/grocery_model.dart';
import 'package:transport4_demo_app/models/ingredients_model.dart';

List<Grocery> groceries = [
  Grocery(
      title: "Pizza",
      ingredients: [
        ShoppingCart(item: "Cheese"),
        ShoppingCart(item: "Tomato"),
        ShoppingCart(item: "Pepperoni")
      ],
      tags: ["pizza", "tasty", "party"],
      fromWeb: false,
      imageUrl: "",
      cookTime: 0,
      servings: 0,
      calories: 0),
  Grocery(
      title: "Taco",
      ingredients: [
        ShoppingCart(item: "Cheese"),
        ShoppingCart(item: "Tomato"),
        ShoppingCart(item: "Ground Beef")
      ],
      tags: ["taco tuesday", "tasty", "party"],
      fromWeb: false,
      imageUrl: "",
      cookTime: 0,
      servings: 0,
      calories: 0),
  Grocery(
      title: "Chicken fettuccine Alfredo",
      ingredients: [
        ShoppingCart(item: "Cheese"),
        ShoppingCart(item: "Chicken"),
        ShoppingCart(item: "Pasta"),
        ShoppingCart(item: "Alfredo"),
      ],
      tags: ["italian", "delicious", "tasty"],
      fromWeb: false,
      imageUrl: "",
      cookTime: 0,
      servings: 0,
      calories: 0)
];
