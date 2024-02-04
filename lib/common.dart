import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport4_demo_app/providers/web_recipe_provider.dart';

String formatText(String text) {
  String str = text;
  return str.replaceAll(RegExp('[^A-Z a-z 0-9]'), '');
}

String convertCalories(double calories) {
  return "${calories.ceil()} kcal";
}

String convertCookTime(double cookTime) {
  return "${cookTime.ceil()} mins";
}

String convertServings(double servings) {
  return servings.ceil().toString();
}

String getTitle(BuildContext context,
    {required int index,
    required int currentIndex,
    required bool isWeb,
    required bool isTags}) {
  final webRecipe = context.watch<WebRecipeProvider>();

  String title = "";

  if (isWeb && isTags) {
    return webRecipe.originalRecipes[index].recipe.tags[currentIndex];
  } else if (isWeb && !isTags) {
    return webRecipe
        .originalRecipes[index].recipe.ingredientLines[currentIndex];
  }

  return title;
}
