import 'package:transport4_demo_app/models/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class RecipeService {
  Future<List<Hit>> getRecipes() async {
    String log = "RecipeService";
    var url = Uri.parse(
        "https://api.edamam.com/api/recipes/v2?type=public&app_id=30f3b536&app_key=63b5ae380f030b8d90929b1b6db216b2&ingr=5-10&time=5-60&imageSize=LARGE&random=true");

    try {
      var response = await http.get(url).timeout(const Duration(seconds: 5));
      developer.log(
        "Response status: ${response.statusCode}",
        name: log,
      );

      if (response.statusCode == 200) {
        Edamam recipes = edamamFromJson(response.body);

        return recipes.hits;
      } else {
        developer.log(
          "Failed to load data. Status code: ${response.statusCode}",
          name: log,
        );
      }
    } catch (e) {
      developer.log(
        "Error loading data: $e",
        name: log,
      );
    }

    return [];
  }
}
