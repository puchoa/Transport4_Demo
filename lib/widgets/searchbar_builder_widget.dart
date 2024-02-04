import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport4_demo_app/providers/my_recipe_provider.dart';
import 'package:transport4_demo_app/providers/web_recipe_provider.dart';

class SearchBarBuilder extends StatefulWidget {
  final bool isWeb;
  const SearchBarBuilder({super.key, required this.isWeb});

  @override
  State<SearchBarBuilder> createState() => _SearchBarBuilderState();
}

class _SearchBarBuilderState extends State<SearchBarBuilder> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  Set shownTags = {};

  bool closeSearch = false;
  int selectedIndex = -1;

  Icon searchIcon = Icon(
    Icons.search,
    color: Colors.grey.shade500,
  );

  @override
  void dispose() {
    searchController.dispose();
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        search(context),
        tagBuilder(context),
        if (context.watch<MyRecipeProvider>().showTags.isEmpty)
          const SizedBox(
            height: 10,
          ),
        Divider(
          height: 2,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }

  SizedBox tagBuilder(
    BuildContext context,
  ) {
    return SizedBox(
      height:
          widget.isWeb || context.watch<MyRecipeProvider>().showTags.isNotEmpty
              ? 50
              : 10,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.isWeb
              ? context.watch<WebRecipeProvider>().showTags.length
              : context.watch<MyRecipeProvider>().showTags.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                searchController.clear();
                final webRecipe = context.read<WebRecipeProvider>();

                final myRecipe = context.read<MyRecipeProvider>();
                setState(() {
                  if (selectedIndex != index) {
                    widget.isWeb
                        ? webRecipe.filterTags(index: index)
                        : myRecipe.filterTags(index: index);

                    searchFocus.unfocus();

                    selectedIndex = index;
                  } else {
                    selectedIndex = -1;
                    widget.isWeb
                        ? webRecipe.resetWebRecipes()
                        : myRecipe.resetWebRecipes();
                  }
                });
              },
              child: SizedBox(
                height: 10,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: 10,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: selectedIndex != -1 && index == selectedIndex
                                ? Colors.blue.shade200
                                : Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            widget.isWeb
                                ? context
                                    .watch<WebRecipeProvider>()
                                    .showTags
                                    .elementAt(index)
                                : context
                                    .watch<MyRecipeProvider>()
                                    .showTags
                                    .elementAt(index),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ),
                      )),
                ),
              ),
            );
          }),
    );
  }

  Container search(
    BuildContext context,
  ) {
    final webRecipe = context.read<WebRecipeProvider>();
    final myRecipe = context.read<MyRecipeProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextField(
        focusNode: searchFocus,
        controller: searchController,
        onChanged: (value) {
          setState(() {});
          if (value.isNotEmpty) {
            searchIcon = Icon(Icons.close, color: Colors.grey.shade500);
            closeSearch = true;
            selectedIndex = -1;
          } else {
            searchIcon = Icon(Icons.search, color: Colors.grey.shade500);
            closeSearch = false;
          }
          widget.isWeb
              ? webRecipe.filterSearch(searchValue: value)
              : myRecipe.filterSearch(searchValue: value);
        },
        decoration: InputDecoration(
          suffixIcon: closeSearch
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                      widget.isWeb
                          ? webRecipe.resetWebRecipes()
                          : myRecipe.resetWebRecipes();
                      searchIcon =
                          Icon(Icons.search, color: Colors.grey.shade500);
                    });
                  },
                  icon: searchIcon)
              : searchIcon,
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey.shade300,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }
}
