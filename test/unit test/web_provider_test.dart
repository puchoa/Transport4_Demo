import 'package:flutter_test/flutter_test.dart';
import 'package:transport4_demo_app/providers/web_recipe_provider.dart';

import 'web_items.dart';

void main() {
  group('WebProvider Functions', () {
    test('delete all tags from item', () {
      final webRecipe = WebRecipeProvider();

      webRecipe.addList(items: hitItems);
      expect(webRecipe.originalRecipes[0].recipe.tags.length, equals(3));
      webRecipe.deleteAllTags(0);
      expect(webRecipe.originalRecipes[0].recipe.tags.length, equals(0));
    });

    test('replacing ingredients from item', () {
      final webRecipe = WebRecipeProvider();

      webRecipe.addList(items: hitItems);
      expect(
          webRecipe.searchRecipes[0].recipe.ingredientLines,
          equals([
            'Pizza dough (store-bought or homemade)',
            'Tomato sauce or marinara sauce',
            'Mozzarella cheese, shredded',
            'Olive oil'
          ]));

      webRecipe.replaceIngredients(0, [
        'Pizza dough (store-bought or homemade)',
        'Tomato sauce or marinara sauce',
        'Mozzarella cheese, shredded',
        'Olive oil',
        'pepperoni'
      ]);

      expect(
          webRecipe.searchRecipes[0].recipe.ingredientLines,
          equals([
            'Pizza dough (store-bought or homemade)',
            'Tomato sauce or marinara sauce',
            'Mozzarella cheese, shredded',
            'Olive oil',
            'pepperoni'
          ]));
    });

    test('filter search should give the correct results', () {
      final webRecipe = WebRecipeProvider();

      webRecipe.addList(items: hitItems);
      expect(webRecipe.searchRecipes[0].recipe.label, equals("Pizza"));
      expect(webRecipe.searchRecipes[1].recipe.label, equals("Taco"));
      expect(webRecipe.searchRecipes[2].recipe.label,
          equals("Chicken fettuccine Alfredo"));

      expect(webRecipe.searchRecipes.length, equals(3));

      webRecipe.filterSearch(searchValue: "c");

      expect(webRecipe.searchRecipes.length, equals(2));
      expect(webRecipe.searchRecipes[0].recipe.label, equals("Taco"));
      expect(webRecipe.searchRecipes[1].recipe.label,
          equals("Chicken fettuccine Alfredo"));
    });

    test('filter search should have track of real index', () {
      final webRecipe = WebRecipeProvider();
      webRecipe.addList(items: hitItems);

      expect(webRecipe.searchRecipes.length, equals(3));
      expect(webRecipe.filterIndex.length, equals(3));
      expect(webRecipe.filterIndex, equals([0, 1, 2]));

      webRecipe.filterSearch(searchValue: "ch");

      expect(webRecipe.searchRecipes.length, equals(1));
      expect(webRecipe.filterIndex.length, equals(1));
      expect(webRecipe.filterIndex.first, equals(2));
    });
  });
}
