import 'package:flutter/material.dart';
import 'package:transport4_demo_app/models/recipe_model.dart';
import 'package:transport4_demo_app/services/recipe_service.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class WebRecipeProvider extends ChangeNotifier {
  final String _log = "WebRecipeProvider";

  List<Hit> _originalRecipes = [];
  List<Hit> get originalRecipes => _originalRecipes;

  List<int> _filterIndex = [];
  List<int> get filterIndex => _filterIndex;

  List<Hit> _searchRecipes = [];
  List<Hit> get searchRecipes => _searchRecipes;

  final Set _showTags = {};
  Set get showTags => _showTags;

  addList({required List<Hit> items}) {
    _originalRecipes = _searchRecipes = items;
    generateIndex();
    setTags();
    notifyListeners();
  }

  setRecipes() async {
    List<Hit> load = await RecipeService(
            api:
                "https://api.edamam.com/api/recipes/v2?type=public&app_id=30f3b536&app_key=63b5ae380f030b8d90929b1b6db216b2&ingr=5-10&time=5-60&imageSize=LARGE&random=true")
        .getRecipes(http.Client());

    _originalRecipes = _searchRecipes = load;
    generateIndex();
    setTags();
  }

  generateIndex() {
    _filterIndex = List.generate(_originalRecipes.length, (index) => index);
    notifyListeners();
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
    generateIndex();

    developer.log(
      "searchRecipes has been reset",
      name: _log,
    );

    notifyListeners();
  }

  filterSearch({required String searchValue}) {
    _filterIndex = originalRecipes
        .asMap()
        .entries
        .where((entry) => entry.value.recipe.label
            .toLowerCase()
            .contains(searchValue.toLowerCase()))
        .map((entry) => entry.key)
        .toList();

    _searchRecipes = originalRecipes
        .where((item) =>
            item.recipe.label.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();

    developer.log(
      "Search has been filtered",
      name: _log,
    );
    notifyListeners();
  }

  filterTags({required int index}) {
    _filterIndex = originalRecipes
        .asMap()
        .entries
        .where((entry) =>
            entry.value.recipe.tags.contains(_showTags.elementAt(index)))
        .map((entry) => entry.key)
        .toList();

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
    for (int i = 0; i < _originalRecipes.length; ++i) {
      for (int j = 0; j < _originalRecipes[i].recipe.tags.length; ++j) {
        _showTags.add(_originalRecipes[i].recipe.tags[j]);
      }
    }

    developer.log(
      "Tags has been updated",
      name: _log,
    );

    notifyListeners();
  }
}
