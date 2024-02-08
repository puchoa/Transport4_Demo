import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport4_demo_app/models/grocery_model.dart';
import 'package:transport4_demo_app/models/ingredients_model.dart';
import 'package:transport4_demo_app/providers/grocery_list_provider.dart';
import 'package:transport4_demo_app/providers/my_recipe_provider.dart';
import 'package:transport4_demo_app/providers/web_recipe_provider.dart';
import 'package:transport4_demo_app/widgets/detail_appbar_widget.dart';
import 'package:transport4_demo_app/widgets/empty_list_widget.dart';
import 'package:transport4_demo_app/widgets/health_percentage_widget.dart';
import 'package:transport4_demo_app/widgets/item_builder_widget.dart';
import 'package:transport4_demo_app/widgets/meal_quick_data_widget.dart';

class RecipeDetails extends StatefulWidget {
  final int index;
  final bool isWeb;
  const RecipeDetails({super.key, required this.index, this.isWeb = false});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  bool saved = false;

  @override
  Widget build(BuildContext context) {
    final webRecipes = context.watch<WebRecipeProvider>();
    final myRecipes = context.watch<MyRecipeProvider>();
    final shopping = context.read<GroceryListProvider>();

    bool check = false;

    for (var item in shopping.groceryList) {
      if (item.title == webRecipes.originalRecipes[widget.index].recipe.label) {
        setState(() {
          saved = true;
        });
        break;
      }
    }

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        DetailAppBar(
            title: widget.isWeb
                ? webRecipes.originalRecipes[widget.index].recipe.label
                : myRecipes.originalRecipes[widget.index].recipe.label,
            imageUrl: widget.isWeb
                ? webRecipes
                    .originalRecipes[widget.index].recipe.images.regular.url
                : myRecipes
                    .originalRecipes[widget.index].recipe.images.regular.url,
            isWeb: widget.isWeb),
        MealDataPreview(
            cookTime: widget.isWeb
                ? webRecipes.originalRecipes[widget.index].recipe.totalTime
                : myRecipes.originalRecipes[widget.index].recipe.totalTime,
            servings: widget.isWeb
                ? webRecipes.originalRecipes[widget.index].recipe.recipeYield!
                : myRecipes.originalRecipes[widget.index].recipe.recipeYield!,
            calories: widget.isWeb
                ? webRecipes.originalRecipes[widget.index].recipe.calories
                : myRecipes.originalRecipes[widget.index].recipe.calories),
        HealthPercentage(
            digest: widget.isWeb
                ? webRecipes.originalRecipes[widget.index].recipe.digest
                : myRecipes.originalRecipes[widget.index].recipe.digest),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Ingredients",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: saved
                          ? null
                          : () {
                              if (!saved) {
                                if (widget.isWeb) {
                                  shopping.addGrocery(
                                      grocery: Grocery(
                                          title: webRecipes
                                              .originalRecipes[widget.index]
                                              .recipe
                                              .label,
                                          ingredients: ShoppingCart().addCart(
                                              webRecipes
                                                  .originalRecipes[widget.index]
                                                  .recipe
                                                  .ingredientLines),
                                          imageUrl: webRecipes
                                              .originalRecipes[widget.index]
                                              .recipe
                                              .images
                                              .regular
                                              .url,
                                          fromWeb: widget.isWeb,
                                          tags: webRecipes
                                              .originalRecipes[widget.index]
                                              .recipe
                                              .tags,
                                          calories: webRecipes
                                              .originalRecipes[widget.index]
                                              .recipe
                                              .calories,
                                          cookTime: webRecipes
                                              .originalRecipes[widget.index]
                                              .recipe
                                              .totalTime,
                                          servings: webRecipes
                                                  .originalRecipes[widget.index]
                                                  .recipe
                                                  .recipeYield ??
                                              0));
                                } else {
                                  shopping.addGrocery(
                                      grocery: Grocery(
                                          title: myRecipes
                                              .originalRecipes[widget.index]
                                              .recipe
                                              .label,
                                          ingredients: ShoppingCart().addCart(
                                              myRecipes
                                                  .originalRecipes[widget.index]
                                                  .recipe
                                                  .ingredientLines),
                                          imageUrl: myRecipes
                                              .originalRecipes[widget.index]
                                              .recipe
                                              .images
                                              .regular
                                              .url,
                                          fromWeb: widget.isWeb,
                                          tags: myRecipes
                                              .originalRecipes[widget.index]
                                              .recipe
                                              .tags,
                                          calories: myRecipes
                                              .originalRecipes[widget.index]
                                              .recipe
                                              .calories,
                                          cookTime: myRecipes
                                              .originalRecipes[widget.index]
                                              .recipe
                                              .totalTime,
                                          servings: myRecipes
                                                  .originalRecipes[widget.index]
                                                  .recipe
                                                  .recipeYield ??
                                              0));
                                }
                              }
                              setState(() {
                                saved = true;
                              });
                            },
                      child: Text(
                        saved ? "Saved" : "Add to Cart",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.isWeb &&
                webRecipes.originalRecipes[widget.index].recipe.ingredientLines
                    .isNotEmpty ||
            !widget.isWeb &&
                myRecipes.originalRecipes[widget.index].recipe.ingredientLines
                    .isNotEmpty) ...[
          ItemBuilder(
            isWeb: widget.isWeb,
            isTags: false,
            index: widget.index,
            isGrocery: false,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 10)),
                      child: const Text(
                        "Let's make it!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    )),
              ],
            ),
          ),
        ],
        if (widget.isWeb &&
                webRecipes.originalRecipes[widget.index].recipe.ingredientLines
                    .isEmpty ||
            !widget.isWeb &&
                myRecipes.originalRecipes[widget.index].recipe.ingredientLines
                    .isEmpty)
          EmptyList(
            isTags: true,
            isWeb: widget.isWeb,
            index: widget.index,
            title: "Ingredients",
          ),
        const SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Tags",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                    ]))),
        if (widget.isWeb &&
                webRecipes.originalRecipes[widget.index].recipe.ingredientLines
                    .isNotEmpty ||
            !widget.isWeb &&
                myRecipes.originalRecipes[widget.index].recipe.ingredientLines
                    .isEmpty)
          ItemBuilder(
            isWeb: widget.isWeb,
            isTags: true,
            index: widget.index,
            isGrocery: false,
          ),
        if (widget.isWeb &&
                webRecipes.originalRecipes[widget.index].recipe.tags.isEmpty ||
            !widget.isWeb &&
                myRecipes.originalRecipes[widget.index].recipe.tags.isEmpty)
          EmptyList(
              isTags: true,
              index: widget.index,
              isWeb: widget.isWeb,
              title: "Tags"),
        const SliverToBoxAdapter(
            child: SizedBox(
          height: 200,
        )),
      ],
    ));
  }
}
