import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport4_demo_app/models/recipe_model.dart';
import 'package:transport4_demo_app/providers/my_recipe_provider.dart';
import 'package:transport4_demo_app/screens/add_items.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({super.key});

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  TextEditingController tagController = TextEditingController();

  bool changeTagLabel = false;
  bool changeIngLabel = false;

  List<String> ingredientItems = [];
  List<String> directionItems = [];
  Set<String> tagItems = {};

  Hit hit = Hit(
    recipe: Recipe(
        uri: "",
        label: "",
        image: "",
        images: Images(
            thumbnail: Regular(url: "", width: 0, height: 0),
            small: Regular(url: "", width: 0, height: 0),
            regular: Regular(url: "", width: 0, height: 0)),
        source: null,
        url: "",
        shareAs: "",
        recipeYield: 0,
        healthLabels: [],
        ingredientLines: [],
        ingredients: [],
        calories: 0,
        totalWeight: 0,
        totalTime: 0,
        totalNutrients: {},
        totalDaily: {},
        digest: [],
        tags: []),
  );

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Create New Recipe"),
        actions: [
          Center(
              child: TextButton(
                  onPressed: () {
                    context.read<MyRecipeProvider>().addRecipe(hit: hit);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  )))
        ],
      ),
      body: ListView(children: [
        Column(children: [
          aboutSection(context),
          healthSection(context),
          sectionTitle(context,
              title: "Ingredients", isIngredients: true, addButton: true),
          listBuilder(context, isIngredients: true),
          if (ingredientItems.isNotEmpty)
            TextButton(
                onPressed: () {
                  setState(() {
                    ingredientItems.clear();
                  });
                },
                child: const Text("Remove All")),
          sectionTitle(context,
              title: "Directions", isDirections: true, addButton: true),
          listBuilder(context, isDirections: true),
          if (directionItems.isNotEmpty)
            TextButton(
                onPressed: () {
                  setState(() {
                    directionItems.clear();
                  });
                },
                child: const Text("Remove All")),
          sectionTitle(context, title: "Tags", isTags: true, addButton: true),
          listBuilder(context, isTags: true),
          if (tagItems.isNotEmpty)
            TextButton(
                onPressed: () {
                  setState(() {
                    tagItems.clear();
                  });
                },
                child: const Text("Remove All")),
          const SizedBox(
            height: 200,
          ),
        ]),
      ]),
    );
  }

  SizedBox listBuilder(BuildContext context,
      {bool isIngredients = false,
      bool isDirections = false,
      bool isTags = false}) {
    int length = 0;

    if (isIngredients) {
      length = ingredientItems.length;
    } else if (isDirections) {
      length = directionItems.length;
    } else {
      length = tagItems.length;
    }
    return SizedBox(
      height: length * MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color:
                        index % 2 == 0 ? Colors.white : Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(isIngredients
                          ? ingredientItems[index]
                          : isDirections
                              ? directionItems[index]
                              : tagItems.elementAt(index)),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (isIngredients) {
                              ingredientItems.removeAt(index);
                            } else if (isDirections) {
                              directionItems.removeAt(index);
                            } else {
                              List<String> coverList = tagItems.toList();
                              coverList.removeAt(index);
                              tagItems = coverList.toSet();
                            }
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey.shade500,
                          size: 20,
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }

  Column healthSection(BuildContext context) {
    return Column(
      children: [
        sectionTitle(context, title: "Health Details"),
        itemDetail(context,
            title: "Total Calories",
            inputType: TextInputType.number,
            hint: "0",
            isCalories: true),
        itemDetail(context,
            title: "Fat",
            inputType: TextInputType.number,
            hint: "Daily %",
            isFat: true),
        itemDetail(context,
            title: "Carbs",
            inputType: TextInputType.number,
            hint: "Daily %",
            isCarbs: true),
        itemDetail(context,
            title: "Protein",
            inputType: TextInputType.number,
            hint: "Daily %",
            isProtein: true),
      ],
    );
  }

  Column aboutSection(BuildContext context) {
    return Column(
      children: [
        sectionTitle(context, title: "About"),
        itemDetail(context,
            title: "Recipe",
            inputType: TextInputType.text,
            hint: "Name",
            isName: true),
        cookTime(context),
        itemDetail(context,
            title: "Servings",
            inputType: TextInputType.number,
            hint: "Feeds how many?",
            isServing: true),
      ],
    );
  }

  Padding cookTime(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        height: 75,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Cooking time"),
              SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  onTimerDurationChanged: (value) {
                    hit.recipe.totalTime = value.inMinutes.toDouble();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container itemDetail(BuildContext context,
      {required String title,
      required TextInputType inputType,
      hint,
      bool isName = false,
      bool isServing = false,
      bool isCalories = false,
      bool isFat = false,
      bool isCarbs = false,
      bool isProtein = false}) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: TextField(
                keyboardType: inputType,
                decoration: InputDecoration(hintText: hint),
                onChanged: (value) {
                  if (isName) {
                    hit.recipe.label = value;
                  }
                  if (isServing) {
                    hit.recipe.recipeYield = double.parse(value);
                  }
                  if (isCalories) {
                    hit.recipe.calories = double.parse(value);
                  }
                  if (isFat) {
                    hit.recipe.digest.add(Digest(
                        label: Label.ENERGY,
                        tag: "",
                        schemaOrgTag: null,
                        total: double.parse(value),
                        hasRdi: false,
                        daily: 0,
                        unit: null));
                  }
                  if (isCarbs) {
                    hit.recipe.digest.add(Digest(
                        label: Label.CARBS,
                        tag: "",
                        schemaOrgTag: null,
                        total: double.parse(value),
                        hasRdi: false,
                        daily: 0,
                        unit: null));
                  }
                  if (isProtein) {
                    hit.recipe.digest.add(Digest(
                        label: Label.PROTEIN,
                        tag: "",
                        schemaOrgTag: null,
                        total: double.parse(value),
                        hasRdi: false,
                        daily: 0,
                        unit: null));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding sectionTitle(BuildContext context,
      {required String title,
      bool isTags = false,
      bool isIngredients = false,
      bool isDirections = false,
      bool addButton = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
          alignment: AlignmentDirectional.centerStart,
          height: 45,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87),
                ),
                addButton
                    ? TextButton(
                        onPressed: () async {
                          List<String> items = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (builder) => AddItems(
                                        isWeb: false,
                                        isTags: false,
                                        title: title,
                                        index: -1,
                                        items: isIngredients
                                            ? ingredientItems
                                            : isDirections
                                                ? directionItems
                                                : tagItems.toList(),
                                      )));

                          setState(() {
                            if (isIngredients) {
                              ingredientItems = items;
                              hit.recipe.ingredientLines = items;
                            } else if (isDirections) {
                              directionItems = items;
                              hit.recipe.directions = items;
                            } else {
                              tagItems.clear();
                              tagItems.addAll(items);
                              hit.recipe.tags = items;
                            }
                          });
                        },
                        child: const Text("Add"))
                    : const SizedBox(),
              ],
            ),
          )),
    );
  }
}
