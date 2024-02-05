import 'package:flutter/material.dart';
import 'package:transport4_demo_app/providers/grocery_list_provider.dart';
import 'package:transport4_demo_app/providers/my_recipe_provider.dart';
import 'package:transport4_demo_app/providers/web_recipe_provider.dart';
import 'package:transport4_demo_app/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WebRecipeProvider()),
        ChangeNotifierProvider(create: (context) => MyRecipeProvider()),
        ChangeNotifierProvider(create: (context) => GroceryListProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.blueAccent,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}
