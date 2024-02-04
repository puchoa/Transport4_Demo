import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transport4_demo_app/common.dart';
import 'package:transport4_demo_app/providers/grocery_list_provider.dart';
import 'package:transport4_demo_app/providers/my_recipe_provider.dart';
import 'package:transport4_demo_app/providers/web_recipe_provider.dart';
import 'package:transport4_demo_app/screens/create_recipe.dart';
import 'package:transport4_demo_app/screens/recipe_details.dart';
import 'package:transport4_demo_app/widgets/recipe_preview_widget.dart';
import 'package:transport4_demo_app/widgets/searchbar_builder_widget.dart';

class RecipesList extends StatefulWidget {
  final bool isWeb;
  const RecipesList({super.key, required this.isWeb});

  @override
  State<RecipesList> createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final webRecipe = context.watch<WebRecipeProvider>();
    final myRecipe = context.watch<MyRecipeProvider>();

    return DefaultTabController(
      length: widget.isWeb ? 0 : 2,
      child: Scaffold(
        body: Column(
          children: [
            SearchBarBuilder(
              isWeb: widget.isWeb,
            ),
            if (!widget.isWeb)
              const TabBar(indicatorColor: Colors.blueAccent, tabs: [
                Tab(
                  child: Text(
                    "My Recipes",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                Tab(
                  child: Text(
                    "Saved",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ]),
            if (!widget.isWeb)
              Expanded(
                  child: TabBarView(children: [
                Tab(
                  child: refreshBuilder(webRecipe, myRecipe),
                ),
                Tab(
                  child: savedRefreshBuilder(),
                )
              ])),
            if (widget.isWeb)
              Expanded(child: refreshBuilder(webRecipe, myRecipe))
          ],
        ),

        // TODO: Remove float button on saved tab
        floatingActionButton: widget.isWeb
            ? null
            : FloatingActionButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) => const CreateRecipe())),
                shape: const CircleBorder(),
                child: const FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  RefreshIndicator refreshBuilder(
      WebRecipeProvider webRecipe, MyRecipeProvider myRecipe) {
    return RefreshIndicator(
      onRefresh: () =>
          widget.isWeb ? webRecipe.setRecipes() : Future.value(null),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: widget.isWeb
              ? webRecipe.searchRecipes.length
              : myRecipe.searchRecipes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  if (widget.isWeb) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => RecipeDetails(
                              isWeb: widget.isWeb,
                              index: index,
                            )));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => RecipeDetails(
                              index: index,
                            )));
                  }
                },
                child: RecipePreview(
                    imageUrl: widget.isWeb
                        ? webRecipe
                            .originalRecipes[index].recipe.images.small.url
                        : myRecipe.searchRecipes[index].recipe.images.small.url,
                    title: widget.isWeb
                        ? formatText(
                            webRecipe.searchRecipes[index].recipe.label)
                        : myRecipe.searchRecipes[index].recipe.label,
                    calories: widget.isWeb
                        ? webRecipe.searchRecipes[index].recipe.calories
                        : myRecipe.searchRecipes[index].recipe.calories,
                    servings: widget.isWeb
                        ? webRecipe.searchRecipes[index].recipe.recipeYield!
                        : myRecipe.searchRecipes[index].recipe.recipeYield!,
                    cookTime: widget.isWeb
                        ? webRecipe.searchRecipes[index].recipe.totalTime
                        : myRecipe.searchRecipes[index].recipe.totalTime,
                    isWeb: widget.isWeb));
          }),
    );
  }

  RefreshIndicator savedRefreshBuilder() {
    final myGrocery = context.watch<GroceryListProvider>();

    return RefreshIndicator(
      onRefresh: () => Future.value(null),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: myGrocery.groceryList.length,
          itemBuilder: (context, index) {
            if (myGrocery.groceryList[index].fromWeb) {
              return GestureDetector(
                  onTap: () {
                    // TODO : Pass data to detail page
                  },
                  child: RecipePreview(
                      imageUrl: myGrocery.groceryList[index].imageUrl,
                      title: myGrocery.groceryList[index].title,
                      calories: myGrocery.groceryList[index].calories,
                      servings: myGrocery.groceryList[index].servings,
                      cookTime: myGrocery.groceryList[index].cookTime,
                      isWeb: true));
            }
            return null;
          }),
    );
  }
}
