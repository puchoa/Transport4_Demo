import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport4_demo_app/common.dart';
import 'package:transport4_demo_app/providers/web_recipe_provider.dart';
import 'package:transport4_demo_app/screens/add_items.dart';

class ItemBuilder extends StatefulWidget {
  final bool isWeb;
  final bool isTags;
  final int index;
  const ItemBuilder(
      {super.key,
      required this.isWeb,
      required this.isTags,
      required this.index});

  @override
  State<ItemBuilder> createState() => _ItemBuilderState();
}

class _ItemBuilderState extends State<ItemBuilder> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: itemLength(context),
            (BuildContext context, int currentindex) {
      return itemBuilder(context, currentindex);
    }));
  }

  int itemLength(BuildContext context) {
    final webRecipe = context.read<WebRecipeProvider>();

    int length = 0;

    if (widget.isWeb && widget.isTags) {
      return webRecipe.originalRecipes[widget.index].recipe.tags.length;
    } else if (widget.isWeb && !widget.isTags) {
      return webRecipe
          .originalRecipes[widget.index].recipe.ingredientLines.length;
    }

    return length;
  }

  Row itemBuilder(BuildContext context, int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * .9,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: currentIndex.isEven ? Colors.white : Colors.grey.shade200,
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Text(
                      formatText(getTitle(context,
                          index: widget.index,
                          currentIndex: currentIndex,
                          isWeb: widget.isWeb,
                          isTags: widget.isTags)),
                      softWrap: true,
                    ),
                  ),
                  if (currentIndex == 0)
                    IconButton(
                      onPressed: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => AddItems(
                                  index: widget.index,
                                  isTags: widget.isTags,
                                  isWeb: widget.isWeb,
                                  items: const [],
                                  title:
                                      !widget.isTags ? "Ingredients" : "Tags",
                                )));

                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    )
                ],
              ),
            )),
      ],
    );
  }
}
