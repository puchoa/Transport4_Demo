import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transport4_demo_app/common.dart';
import 'package:transport4_demo_app/models/grocery_model.dart';
import 'package:transport4_demo_app/models/ingredients_model.dart';
import 'package:transport4_demo_app/providers/grocery_list_provider.dart';
import 'package:uuid/uuid.dart';

class ShoppingList extends StatefulWidget {
  final String title;
  final List<ShoppingCart>? items;
  final bool newCart;
  final bool allIngredients;
  const ShoppingList(
      {super.key,
      required this.title,
      this.items,
      this.newCart = false,
      this.allIngredients = false});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  TextEditingController addItemController = TextEditingController();
  bool floatPressed = false;
  List<ShoppingCart> createCart = [];
  bool editTitle = false;
  String updateTitle = "";

  @override
  void dispose() {
    addItemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myGrocery = context.watch<GroceryListProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (createCart.isNotEmpty) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Unsaved Changes"),
                      content: const Text(
                          "You have unsaved changes. Are you sure you want to discard these changes and exit?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Discard Changes"))
                      ],
                    );
                  });
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          if (widget.newCart)
            TextButton(
                onPressed: createCart.isEmpty
                    ? null
                    : () {
                        context.read<GroceryListProvider>().addGrocery(
                            grocery: Grocery(
                                title: updateTitle.isNotEmpty
                                    ? updateTitle
                                    : widget.title,
                                ingredients: createCart,
                                tags: [],
                                imageUrl: "",
                                fromWeb: false,
                                calories: 0,
                                servings: 0,
                                cookTime: 0));
                        Navigator.of(context).pop();
                      },
                child: const Text("Save"))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: !widget.allIngredients
                  ? null
                  : () {
                      setState(() {
                        addItemController.text = updateTitle;
                        editTitle = !editTitle;
                        floatPressed = true;
                      });
                    },
              child: Text(
                updateTitle.isNotEmpty ? updateTitle : widget.title,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          if (widget.items == null)
            Expanded(
              child: ListView(
                children: [
                  for (var groceryList in myGrocery.groceryList)
                    for (var item in groceryList.ingredients)
                      Dismissible(
                        key: Key(const Uuid().v4()),
                        background: Container(
                          color: Colors.red,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50.0),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            groceryList.ingredients
                                .removeWhere((element) => element == item);
                          });
                        },
                        child: ListTile(
                          leading: widget.newCart
                              ? null
                              : Checkbox(
                                  value: item.selected,
                                  onChanged: (onChanged) {
                                    setState(() {
                                      item.selected = onChanged!;
                                    });
                                  }),
                          title: Text(formatText(item.item)),
                        ),
                      ),
                ],
              ),
            ),
          if (widget.newCart)
            Expanded(
              child: ListView.builder(
                itemCount: createCart.length,
                itemBuilder: (context, index) {
                  return dismissibleItem(index);
                },
              ),
            ),
          if (widget.items != null)
            Expanded(
              child: ListView.builder(
                itemCount: widget.items!.length,
                itemBuilder: (context, index) {
                  return dismissibleItem(index);
                },
              ),
            ),
          if (floatPressed)
            SafeArea(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade300),
                child: TextField(
                  controller: addItemController,
                  autofocus: floatPressed,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      hintText: editTitle
                          ? updateTitle.isEmpty
                              ? "Update title"
                              : updateTitle
                          : "Add new items",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              floatPressed = !floatPressed;
                            });
                          },
                          icon: const Icon(Icons.close))),
                  onChanged: (value) {
                    setState(() {
                      if (editTitle) {
                        updateTitle = addItemController.text;
                      }
                    });
                  },
                  onEditingComplete: () {
                    setState(() {
                      if (addItemController.text.isNotEmpty) {
                        if (editTitle) {
                          updateTitle = addItemController.text;
                          editTitle = !editTitle;
                        } else {
                          if (!widget.newCart) {
                            widget.items!.add(
                                ShoppingCart(item: addItemController.text));
                          } else {
                            createCart.add(
                                ShoppingCart(item: addItemController.text));
                          }
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
      floatingActionButton: !floatPressed && widget.items != null
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  floatPressed = true;
                });
              },
              shape: const CircleBorder(),
              child: const FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  Dismissible dismissibleItem(int index) {
    return Dismissible(
      key: Key(const Uuid().v4()),
      background: Container(
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              )),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          widget.items!.removeAt(index);
        });
      },
      child: ListTile(
        leading: Checkbox(
            value: widget.newCart
                ? createCart[index].selected
                : widget.items![index].selected,
            onChanged: (onChanged) {
              setState(() {
                widget.newCart
                    ? createCart[index].selected = onChanged!
                    : widget.items![index].selected = onChanged!;
              });
            }),
        title: Text(formatText(widget.newCart
            ? createCart[index].item
            : widget.items![index].item)),
      ),
    );
  }
}
