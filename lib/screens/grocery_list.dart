import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transport4_demo_app/providers/grocery_list_provider.dart';
import 'package:transport4_demo_app/screens/shopping_list.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  bool showDelete = false;
  @override
  Widget build(BuildContext context) {
    final myGrocery = context.watch<GroceryListProvider>();
    final myGroceryRead = context.read<GroceryListProvider>();

    return Scaffold(
      appBar: appBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (myGrocery.groceryList.isEmpty)
            const Align(
              alignment: Alignment.center,
              child: Text("Add items to your list"),
            ),
          if (myGrocery.groceryList.isNotEmpty) ...[
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 30.0, left: 30, top: 30),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => ShoppingList(
                          title: "All Ingredients",
                          tags: myGrocery.allTags(),
                          index: -1,
                        ),
                      ));
                    },
                    child: entireCart(context),
                  ),
                ),
                deleteButton(),
              ],
            ),
            gridView(myGrocery, myGroceryRead)
          ]
        ],
      ),
    );
  }

  Padding deleteButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, top: 10),
      child: Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () {
                setState(() {
                  showDelete = !showDelete;
                });
              },
              child: Text(
                showDelete ? "Done" : "Delete",
                style: TextStyle(color: Colors.grey.shade600),
              ))),
    );
  }

  Expanded gridView(
      GroceryListProvider myGrocery, GroceryListProvider myGroceryRead) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
          itemCount: myGrocery.groceryList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            int inverseIndex = myGrocery.groceryList.length - 1 - index;
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => ShoppingList(
                    title: myGrocery.groceryList[inverseIndex].title,
                    items: myGrocery.groceryList[inverseIndex].ingredients,
                    tags: myGrocery.groceryList[inverseIndex].tags,
                    index: inverseIndex,
                  ),
                ));
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: itemBox(myGrocery, inverseIndex),
                  ),
                  if (showDelete) deleteIcon(myGroceryRead, inverseIndex),
                ],
              ),
            );
          }),
    ));
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Grocery List",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
          )),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => const ShoppingList(
                  title: "New List",
                  newCart: true,
                  items: [],
                  tags: [],
                  index: -1,
                  allIngredients: true,
                ),
              ));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Create List",
                style: TextStyle(color: Colors.black),
              ),
            ))
      ],
    );
  }

  Positioned deleteIcon(GroceryListProvider myGroceryRead, int index) {
    return Positioned(
        top: 0.0,
        right: 0,
        child: Container(
          height: 40,
          decoration: const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 3,
                  blurRadius: 0,
                ),
              ]),
          child: IconButton(
              onPressed: () {
                myGroceryRead.removeItem(index: index);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              )),
        ));
  }

  Padding itemBox(GroceryListProvider myGrocery, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            image: myGrocery.groceryList[index].imageUrl.isEmpty
                ? null
                : DecorationImage(
                    image: NetworkImage(myGrocery.groceryList[index].imageUrl),
                    fit: BoxFit.cover,
                  ),
            color: Colors.green.shade300,
            borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.5),
              borderRadius: BorderRadius.circular(12)),
          child: Text(
            myGrocery.groceryList[index].title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 19,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Container entireCart(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: FaIcon(
              FontAwesomeIcons.cartShopping,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text("All Ingredients",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
