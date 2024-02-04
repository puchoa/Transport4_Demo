import 'package:flutter/material.dart';
import 'package:transport4_demo_app/models/recipe_model.dart';
import 'package:transport4_demo_app/services/recipe_service.dart';
import 'dart:developer' as developer;

class WebRecipeProvider extends ChangeNotifier {
  final String _log = "WebRecipeProvider";

  List<Hit> _originalRecipes = [];
  List<Hit> get originalRecipes => _originalRecipes;

  List<Hit> _searchRecipes = [];
  List<Hit> get searchRecipes => _searchRecipes;

  final Set _showTags = {};
  Set get showTags => _showTags;

  setRecipes() async {
    List<Hit> load = await RecipeService().getRecipes();

    _originalRecipes = _searchRecipes = load;
    setTags();
  }

  deleteAllTags(int index) {
    _originalRecipes[index].recipe.tags.clear();

    developer.log(
      "Tags has been cleared",
      name: _log,
    );
    notifyListeners();
  }

  replaceTags(int index, List<String> tags) {
    _originalRecipes[index].recipe.tags = tags;

    developer.log(
      "Tags has been replaced",
      name: _log,
    );
    notifyListeners();
  }

  replaceIngredients(int index, List<String> ingredients) {
    _originalRecipes[index].recipe.ingredientLines = ingredients;

    developer.log(
      "Ingredients has been replaced",
      name: _log,
    );
    notifyListeners();
  }

  resetWebRecipes() {
    _searchRecipes = _originalRecipes;

    developer.log(
      "searchRecipes has been reset",
      name: _log,
    );

    notifyListeners();
  }

  filterSearch({required String searchValue}) {
    _searchRecipes = originalRecipes
        .where((item) => item.recipe.label.toLowerCase().contains(searchValue))
        .toList();

    developer.log(
      "Search has been filtered",
      name: _log,
    );
    notifyListeners();
  }

  filterTags({required int index}) {
    _searchRecipes = _originalRecipes
        .where((item) => item.recipe.tags.contains(_showTags.elementAt(index)))
        .toList();

    developer.log(
      "Tags has been filtered",
      name: _log,
    );
    notifyListeners();
  }

  setTags() {
    _showTags.clear();
    for (int i = 0; i < _searchRecipes.length; ++i) {
      for (int j = 0; j < _searchRecipes[i].recipe.tags.length; ++j) {
        _showTags.add(_searchRecipes[i].recipe.tags[j]);
      }
    }

    developer.log(
      "Tags has been updated",
      name: _log,
    );

    notifyListeners();
  }
}
