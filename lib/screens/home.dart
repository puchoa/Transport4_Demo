import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transport4_demo_app/providers/web_recipe_provider.dart';

import 'package:transport4_demo_app/screens/grocery_list.dart';
import 'package:transport4_demo_app/screens/recpies_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final screens = const [
    GroceryList(),
    RecipesList(isWeb: false),
    RecipesList(isWeb: true),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WebRecipeProvider>().setRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Container bottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
      ),
      child: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey.shade500,
        selectedItemColor: Colors.grey.shade800,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.cartPlus,
            ),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.bowlRice,
            ),
            label: 'My Recipes',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.globe,
            ),
            label: 'Community',
          ),
        ],
        currentIndex: selectedIndex,
      ),
    );
  }
}
