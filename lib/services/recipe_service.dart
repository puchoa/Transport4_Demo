import 'package:transport4_demo_app/models/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class RecipeService {
  final String api;
  RecipeService({required this.api});

  Future<List<Hit>> getRecipes(http.Client client) async {
    String log = "RecipeService";
    var url = Uri.parse(api);

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
