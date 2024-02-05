import 'package:flutter/material.dart';

class MealDataPreview extends StatefulWidget {
  final double cookTime;
  final double servings;
  final double calories;
  const MealDataPreview(
      {super.key,
      required this.cookTime,
      required this.servings,
      required this.calories});
  @override
  State<MealDataPreview> createState() => _MealDataPreviewState();
}

class _MealDataPreviewState extends State<MealDataPreview> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                recipeInfo(
                    title: "${widget.cookTime.ceil()} mins",
                    icon: Icons.watch_later_outlined),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: recipeInfo(
                      title: widget.servings.ceil().toString(),
                      icon: Icons.people_alt_outlined),
                ),
                recipeInfo(
                    title: "${widget.calories.ceil()} kcal",
                    icon: Icons.offline_bolt_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container recipeInfo({required String title, required icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              title,
            ),
          ),
        ],
      ),
    );
  }
}
