import 'package:transport4_demo_app/models/ingredients_model.dart';

class Grocery {
  String title;
  List<ShoppingCart> ingredients;
  List<String> tags;
  String imageUrl;
  bool fromWeb;
  double cookTime;
  double servings;
  double calories;

  Grocery(
      {required this.title,
      required this.ingredients,
      required this.tags,
      required this.fromWeb,
      required this.imageUrl,
      required this.cookTime,
      required this.servings,
      required this.calories});
}
