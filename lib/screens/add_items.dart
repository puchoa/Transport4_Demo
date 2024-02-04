import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport4_demo_app/common.dart';
import 'package:transport4_demo_app/providers/web_recipe_provider.dart';

class AddItems extends StatefulWidget {
  final String title;

  final bool isWeb;
  final bool isTags;
  final int index;
  final List<String> items;
  const AddItems(
      {super.key,
      required this.isWeb,
      required this.title,
      required this.isTags,
      required this.index,
      required this.items});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  TextEditingController addItemController = TextEditingController();
  List<String> currentItems = [];

  @override
  void dispose() {
    addItemController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.items.isNotEmpty) {
      currentItems = widget.items;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final webRecipesRead = context.read<WebRecipeProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(currentItems);

            if (widget.isWeb) {
              if (widget.isTags) {
                webRecipesRead.replaceTags(widget.index, currentItems);
              } else {
                webRecipesRead.replaceIngredients(widget.index, currentItems);
              }
            } else {
              if (widget.isTags) {
              } else {}
            }
          },
        ),
        title: Text(widget.title),
        actions: [
          TextButton(
              onPressed: () {
                if (widget.isTags && widget.isWeb) {
                  webRecipesRead.deleteAllTags(widget.index);
                }
                setState(() {});
              },
              child: const Text("Remove All"))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: itemLength(context, widget.index),
                  itemBuilder: (context, currentIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: currentIndex.isEven
                                ? Colors.white
                                : Colors.grey.shade200),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  formatText(currentItems.isNotEmpty
                                      ? currentItems[currentIndex]
                                      : getTitle(context,
                                          index: widget.index,
                                          currentIndex: currentIndex,
                                          isWeb: widget.isWeb,
                                          isTags: widget.isTags)),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (currentItems.isNotEmpty) {
                                      currentItems.removeAt(currentIndex);
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
                  })),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: TextField(
                controller: addItemController,
                autofocus: true,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Add new items"),
                onEditingComplete: () {
                  setState(() {
                    if (addItemController.text.isNotEmpty) {
                      if (widget.isWeb) {
                        if (widget.isTags) {
                          webRecipesRead
                              .originalRecipes[widget.index].recipe.tags
                              .add(addItemController.text);
                        } else if (!widget.isTags) {
                          webRecipesRead.originalRecipes[widget.index].recipe
                              .ingredientLines
                              .add(addItemController.text);
                        }
                      } else {
                        currentItems.add(addItemController.text);
                      }

                      addItemController.clear();
                    }
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  int itemLength(BuildContext context, int index) {
    final webRecipe = context.watch<WebRecipeProvider>();

    int length = 0;

    if (widget.isWeb) {
      if (widget.isTags) {
        return webRecipe.originalRecipes[index].recipe.tags.length;
      } else if (!widget.isTags) {
        return webRecipe.originalRecipes[index].recipe.ingredientLines.length;
      }
    } else {
      return currentItems.length;
    }

    return length;
  }
}
