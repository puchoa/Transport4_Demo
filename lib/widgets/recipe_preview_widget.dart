import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:transport4_demo_app/common.dart';
import 'dart:developer' as developer;

class RecipePreview extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double calories;
  final double servings;
  final double cookTime;
  final bool isWeb;
  const RecipePreview(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.calories,
      required this.servings,
      required this.cookTime,
      required this.isWeb});

  @override
  State<RecipePreview> createState() => _RecipePreviewState();
}

class _RecipePreviewState extends State<RecipePreview> {
  @override
  Widget build(BuildContext context) {
    return recipe(context,
        imageUrl: widget.imageUrl,
        isWeb: widget.isWeb,
        title: widget.title,
        calories: convertCalories(widget.calories),
        servings: convertServings(widget.servings),
        cookTime: convertCookTime(widget.cookTime));
  }
}

Padding recipeDetails(BuildContext context,
    {required String title,
    required String cookTime,
    required String servings,
    required String calories}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            recipeInfo(title: cookTime, icon: Icons.watch_later_outlined),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  recipeInfo(title: servings, icon: Icons.people_alt_outlined),
            ),
            recipeInfo(title: calories, icon: Icons.offline_bolt_outlined),
          ],
        ),
      ],
    ),
  );
}

Container recipeInfo({required String title, required icon}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade500),
        Padding(
          padding: const EdgeInsets.only(
            left: 3.0,
          ),
          child: Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ),
      ],
    ),
  );
}

Padding recipe(BuildContext context,
    {required String imageUrl,
    required bool isWeb,
    required String title,
    required String cookTime,
    required String servings,
    required String calories}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            isWeb ? circleImage(imageUrl) : missingImage(),
            recipeDetails(context,
                title: title,
                cookTime: cookTime,
                servings: servings,
                calories: calories),
          ],
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Colors.grey.shade500,
        )
      ],
    ),
  );
}

ClipOval circleImage(url) {
  try {
    return ClipOval(
        child: FadeInImage.memoryNetwork(
            fit: BoxFit.cover,
            width: 70,
            height: 70,
            placeholder: kTransparentImage,
            image: url,
            imageErrorBuilder: (context, error, stackTrace) {
              return missingImage();
            }));
  } catch (e) {
    developer.log(
      "Error loading data: $e",
      name: "DetailAppBar",
    );
  }
  return ClipOval(child: missingImage());
}

Container missingImage() {
  return Container(
    width: 70,
    height: 70,
    decoration: BoxDecoration(
      color: Colors.red.shade400,
      shape: BoxShape.circle,
    ),
    child: const Center(
      child: FaIcon(
        FontAwesomeIcons.image,
        color: Colors.white,
        size: 40.0,
      ),
    ),
  );
}
