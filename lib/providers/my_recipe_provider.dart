import 'package:flutter/material.dart';
import 'package:transport4_demo_app/models/recipe_model.dart';

class MyRecipeProvider extends ChangeNotifier {
  final List<Hit> _originalRecipes = [];
  List<Hit> get originalRecipes => _originalRecipes;

  List<Hit> _searchRecipes = [];
  List<Hit> get searchRecipes => _searchRecipes;

  final Set _showTags = {};
  Set get showTags => _showTags;

  addRecipe({required Hit hit}) async {
    _originalRecipes.add(hit);

    _searchRecipes = _originalRecipes;

    if (hit.recipe.tags.isNotEmpty) {
      setTags();
    }
    notifyListeners();
  }

  resetWebRecipes() {
    _searchRecipes = _originalRecipes;
    notifyListeners();
  }

  filterSearch({required String searchValue}) {
    _searchRecipes = originalRecipes
        .where((item) => item.recipe.label.toLowerCase().contains(searchValue))
        // .where((item) => item.recipe.tags!.contains(searchValue))
        .toList();
    notifyListeners();
  }

  filterTags({required int index}) {
    _searchRecipes = _originalRecipes
        .where((item) => item.recipe.tags.contains(_showTags.elementAt(index)))
        .toList();
    notifyListeners();
  }

  setTags() {
    _showTags.clear();
    for (int i = 0; i < _searchRecipes.length; ++i) {
      if (_searchRecipes[i].recipe.tags.isNotEmpty) {
        for (int j = 0; j < _searchRecipes[i].recipe.tags.length; ++j) {
          _showTags.add(_searchRecipes[i].recipe.tags[j]);
        }
      }
    }

    notifyListeners();
  }
}
