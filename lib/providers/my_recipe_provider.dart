import 'package:flutter/material.dart';
import 'package:transport4_demo_app/models/recipe_model.dart';

class MyRecipeProvider extends ChangeNotifier {
  final List<Hit> _originalRecipes = [];
  List<Hit> get originalRecipes => _originalRecipes;

  List<Hit> _searchRecipes = [];
  List<Hit> get searchRecipes => _searchRecipes;

  List<int> _filterIndex = [];
  List<int> get filterIndex => _filterIndex;

  final Set _showTags = {};
  Set get showTags => _showTags;

  addRecipe({required Hit hit}) async {
    _originalRecipes.add(hit);

    _searchRecipes = _originalRecipes;
    generateIndex();

    if (hit.recipe.tags.isNotEmpty) {
      setTags();
    }
    notifyListeners();
  }

  generateIndex() {
    _filterIndex = List.generate(_originalRecipes.length, (index) => index);
    notifyListeners();
  }

  resetWebRecipes() {
    _searchRecipes = _originalRecipes;
    generateIndex();

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

    notifyListeners();
  }

  setTags() {
    _showTags.clear();
    for (int i = 0; i < _originalRecipes.length; ++i) {
      if (_originalRecipes[i].recipe.tags.isNotEmpty) {
        for (int j = 0; j < _originalRecipes[i].recipe.tags.length; ++j) {
          _showTags.add(_originalRecipes[i].recipe.tags[j]);
        }
      }
    }

    notifyListeners();
  }
}
