// To parse this JSON data, do
//
//     final edamam = edamamFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

Edamam edamamFromJson(String str) => Edamam.fromJson(json.decode(str));

String edamamToJson(Edamam data) => json.encode(data.toJson());

class Edamam {
  // int from;
  // int to;
  // int count;
  // EdamamLinks links;
  List<Hit> hits;

  Edamam({
    // required this.from,
    // required this.to,
    // required this.count,
    // required this.links,
    required this.hits,
  });

  factory Edamam.fromJson(Map<String, dynamic> json) => Edamam(
        // from: json["from"],
        // to: json["to"],
        // count: json["count"],
        // links: EdamamLinks.fromJson(json["_links"]),
        hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "from": from,
        // "to": to,
        // "count": count,
        // "_links": links.toJson(),
        "hits": List<dynamic>.from(hits.map((x) => x.toJson())),
      };
}

class Hit {
  Recipe recipe;
  // HitLinks links;

  Hit({
    required this.recipe,
    // required this.links,
  });

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        recipe: Recipe.fromJson(json["recipe"]),
        // links: HitLinks.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "recipe": recipe.toJson(),
        // "_links": links.toJson(),
      };
}

// class HitLinks {
//   Next self;

//   HitLinks({
//     required this.self,
//   });

//   factory HitLinks.fromJson(Map<String, dynamic> json) => HitLinks(
//         self: Next.fromJson(json["self"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "self": self.toJson(),
//       };
// }

// class Next {
//   String href;
//   Title title;

//   Next({
//     required this.href,
//     required this.title,
//   });

//   factory Next.fromJson(Map<String, dynamic> json) => Next(
//         href: json["href"],
//         title: titleValues.map[json["title"]]!,
//       );

//   Map<String, dynamic> toJson() => {
//         "href": href,
//         "title": titleValues.reverse[title],
//       };
// }

// enum Title { NEXT_PAGE, SELF }

// final titleValues =
//     EnumValues({"Next page": Title.NEXT_PAGE, "Self": Title.SELF});

class Recipe {
  String uri;
  String label;
  String image;
  Images images;
  Source? source;
  String url;
  String shareAs;
  double? recipeYield;
  // List<DietLabel> dietLabels;
  List<String> healthLabels;
  List<String>? directions;

  // List<Caution?> cautions;
  List<String> ingredientLines;
  List<Ingredient> ingredients;
  double calories;
  // double totalCo2Emissions;
  // String co2EmissionsClass;
  double totalWeight;
  double totalTime;
  // List<CuisineType?> cuisineType;
  // List<MealType> mealType;
  List<String>? dishType;
  Map<String, Total> totalNutrients;
  Map<String, Total> totalDaily;
  List<Digest> digest;
  List<String> tags;

  Recipe({
    required this.uri,
    required this.label,
    required this.image,
    required this.images,
    required this.source,
    required this.url,
    required this.shareAs,
    required this.recipeYield,
    // required this.dietLabels,
    required this.healthLabels,
    this.directions,
    // required this.cautions,
    required this.ingredientLines,
    required this.ingredients,
    required this.calories,
    // required this.totalCo2Emissions,
    // required this.co2EmissionsClass,
    required this.totalWeight,
    required this.totalTime,
    // required this.cuisineType,
    // required this.mealType,
    this.dishType,
    required this.totalNutrients,
    required this.totalDaily,
    required this.digest,
    required this.tags,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        uri: json["uri"],
        label: json["label"],
        image: json["image"],
        images: Images.fromJson(json["images"]),
        source: sourceValues.map[json["source"]],
        url: json["url"],
        shareAs: json["shareAs"],
        recipeYield: json["yield"],
        // dietLabels: List<DietLabel>.from(
        //     json["dietLabels"].map((x) => dietLabelValues.map[x]!)),
        healthLabels: List<String>.from(json["healthLabels"].map((x) => x)),
        // cautions: List<Caution>.from(
        //     json["cautions"].map((x) => cautionValues.map[x])),
        ingredientLines:
            List<String>.from(json["ingredientLines"].map((x) => x)),
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromJson(x))),
        calories: json["calories"]?.toDouble(),
        // totalCo2Emissions: json["totalCO2Emissions"]?.toDouble(),
        // co2EmissionsClass: json["co2EmissionsClass"],
        totalWeight: json["totalWeight"]?.toDouble(),
        totalTime: json["totalTime"],
        // cuisineType: List<CuisineType>.from(
        //     json["cuisineType"].map((x) => cuisineTypeValues.map[x])),
        // mealType: List<MealType>.from(
        //     json["mealType"].map((x) => mealTypeValues.map[x])),
        dishType: json["dishType"] == null
            ? []
            : List<String>.from(json["dishType"]!.map((x) => x)),
        totalNutrients: Map.from(json["totalNutrients"])
            .map((k, v) => MapEntry<String, Total>(k, Total.fromJson(v))),
        totalDaily: Map.from(json["totalDaily"])
            .map((k, v) => MapEntry<String, Total>(k, Total.fromJson(v))),
        digest:
            List<Digest>.from(json["digest"].map((x) => Digest.fromJson(x))),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "label": label,
        "image": image,
        "images": images.toJson(),
        "source": sourceValues.reverse[source],
        "url": url,
        "shareAs": shareAs,
        "yield": recipeYield,
        // "dietLabels": List<dynamic>.from(
        //     dietLabels.map((x) => dietLabelValues.reverse[x])),
        "healthLabels": List<dynamic>.from(healthLabels.map((x) => x)),
        // "cautions":
        //     List<dynamic>.from(cautions.map((x) => cautionValues.reverse[x])),
        "ingredientLines": List<dynamic>.from(ingredientLines.map((x) => x)),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "calories": calories,
        // "totalCO2Emissions": totalCo2Emissions,
        // "co2EmissionsClass": co2EmissionsClass,
        "totalWeight": totalWeight,
        "totalTime": totalTime,
        // "cuisineType": List<dynamic>.from(
        //     cuisineType.map((x) => cuisineTypeValues.reverse[x])),
        // "mealType":
        //     List<dynamic>.from(mealType.map((x) => mealTypeValues.reverse[x])),
        "dishType":
            dishType == null ? [] : List<dynamic>.from(dishType!.map((x) => x)),
        "totalNutrients": Map.from(totalNutrients)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "totalDaily": Map.from(totalDaily)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "digest": List<dynamic>.from(digest.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };
}

// enum Caution { SULFITES }

// final cautionValues = EnumValues({"Sulfites": Caution.SULFITES});

// enum CuisineType { AMERICAN, KOREAN }

// final cuisineTypeValues = EnumValues(
//     {"american": CuisineType.AMERICAN, "korean": CuisineType.KOREAN});

// enum DietLabel {
//   BALANCED,
//   HIGH_FIBER,
//   HIGH_PROTEIN,
//   LOW_CARB,
//   LOW_FAT,
//   LOW_SODIUM
// }

// final dietLabelValues = EnumValues({
//   "Balanced": DietLabel.BALANCED,
//   "High-Fiber": DietLabel.HIGH_FIBER,
//   "High-Protein": DietLabel.HIGH_PROTEIN,
//   "Low-Carb": DietLabel.LOW_CARB,
//   "Low-Fat": DietLabel.LOW_FAT,
//   "Low-Sodium": DietLabel.LOW_SODIUM
// });

class Digest {
  Label label;
  String tag;
  SchemaOrgTag? schemaOrgTag;
  double total;
  bool hasRdi;
  double daily;
  Unit? unit;
  List<Digest>? sub;

  Digest({
    required this.label,
    required this.tag,
    required this.schemaOrgTag,
    required this.total,
    required this.hasRdi,
    required this.daily,
    required this.unit,
    this.sub,
  });

  factory Digest.fromJson(Map<String, dynamic> json) => Digest(
        label: labelValues.map[json["label"]]!,
        tag: json["tag"],
        schemaOrgTag: schemaOrgTagValues.map[json["schemaOrgTag"]],
        total: json["total"]?.toDouble(),
        hasRdi: json["hasRDI"],
        daily: json["daily"]?.toDouble(),
        unit: unitValues.map[json["unit"]],
        sub: json["sub"] == null
            ? []
            : List<Digest>.from(json["sub"]!.map((x) => Digest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "label": labelValues.reverse[label],
        "tag": tag,
        "schemaOrgTag": schemaOrgTagValues.reverse[schemaOrgTag],
        "total": total,
        "hasRDI": hasRdi,
        "daily": daily,
        "unit": unitValues.reverse[unit],
        "sub":
            sub == null ? [] : List<dynamic>.from(sub!.map((x) => x.toJson())),
      };
}

enum Label {
  CALCIUM,
  CARBOHYDRATES_NET,
  CARBS,
  CARBS_NET,
  CHOLESTEROL,
  ENERGY,
  FAT,
  FIBER,
  FOLATE_EQUIVALENT_TOTAL,
  FOLATE_FOOD,
  FOLIC_ACID,
  IRON,
  MAGNESIUM,
  MONOUNSATURATED,
  NIACIN_B3,
  PHOSPHORUS,
  POLYUNSATURATED,
  POTASSIUM,
  PROTEIN,
  RIBOFLAVIN_B2,
  SATURATED,
  SODIUM,
  SUGARS,
  SUGARS_ADDED,
  SUGAR_ALCOHOLS,
  THIAMIN_B1,
  TRANS,
  VITAMIN_A,
  VITAMIN_B12,
  VITAMIN_B6,
  VITAMIN_C,
  VITAMIN_D,
  VITAMIN_E,
  VITAMIN_K,
  WATER,
  ZINC
}

final labelValues = EnumValues({
  "Calcium": Label.CALCIUM,
  "Carbohydrates (net)": Label.CARBOHYDRATES_NET,
  "Carbs": Label.CARBS,
  "Carbs (net)": Label.CARBS_NET,
  "Cholesterol": Label.CHOLESTEROL,
  "Energy": Label.ENERGY,
  "Fat": Label.FAT,
  "Fiber": Label.FIBER,
  "Folate equivalent (total)": Label.FOLATE_EQUIVALENT_TOTAL,
  "Folate (food)": Label.FOLATE_FOOD,
  "Folic acid": Label.FOLIC_ACID,
  "Iron": Label.IRON,
  "Magnesium": Label.MAGNESIUM,
  "Monounsaturated": Label.MONOUNSATURATED,
  "Niacin (B3)": Label.NIACIN_B3,
  "Phosphorus": Label.PHOSPHORUS,
  "Polyunsaturated": Label.POLYUNSATURATED,
  "Potassium": Label.POTASSIUM,
  "Protein": Label.PROTEIN,
  "Riboflavin (B2)": Label.RIBOFLAVIN_B2,
  "Saturated": Label.SATURATED,
  "Sodium": Label.SODIUM,
  "Sugars": Label.SUGARS,
  "Sugars, added": Label.SUGARS_ADDED,
  "Sugar alcohols": Label.SUGAR_ALCOHOLS,
  "Thiamin (B1)": Label.THIAMIN_B1,
  "Trans": Label.TRANS,
  "Vitamin A": Label.VITAMIN_A,
  "Vitamin B12": Label.VITAMIN_B12,
  "Vitamin B6": Label.VITAMIN_B6,
  "Vitamin C": Label.VITAMIN_C,
  "Vitamin D": Label.VITAMIN_D,
  "Vitamin E": Label.VITAMIN_E,
  "Vitamin K": Label.VITAMIN_K,
  "Water": Label.WATER,
  "Zinc": Label.ZINC
});

enum SchemaOrgTag {
  CARBOHYDRATE_CONTENT,
  CHOLESTEROL_CONTENT,
  FAT_CONTENT,
  FIBER_CONTENT,
  PROTEIN_CONTENT,
  SATURATED_FAT_CONTENT,
  SODIUM_CONTENT,
  SUGAR_CONTENT,
  TRANS_FAT_CONTENT
}

final schemaOrgTagValues = EnumValues({
  "carbohydrateContent": SchemaOrgTag.CARBOHYDRATE_CONTENT,
  "cholesterolContent": SchemaOrgTag.CHOLESTEROL_CONTENT,
  "fatContent": SchemaOrgTag.FAT_CONTENT,
  "fiberContent": SchemaOrgTag.FIBER_CONTENT,
  "proteinContent": SchemaOrgTag.PROTEIN_CONTENT,
  "saturatedFatContent": SchemaOrgTag.SATURATED_FAT_CONTENT,
  "sodiumContent": SchemaOrgTag.SODIUM_CONTENT,
  "sugarContent": SchemaOrgTag.SUGAR_CONTENT,
  "transFatContent": SchemaOrgTag.TRANS_FAT_CONTENT
});

enum Unit { EMPTY, G, KCAL, MG, UNIT_G }

final unitValues = EnumValues({
  "%": Unit.EMPTY,
  "g": Unit.G,
  "kcal": Unit.KCAL,
  "mg": Unit.MG,
  "µg": Unit.UNIT_G
});

class Images {
  Regular thumbnail;
  Regular small;
  Regular regular;
  Regular? large;

  Images({
    required this.thumbnail,
    required this.small,
    required this.regular,
    this.large,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        thumbnail: Regular.fromJson(json["THUMBNAIL"]),
        small: Regular.fromJson(json["SMALL"]),
        regular: Regular.fromJson(json["REGULAR"]),
        large: json["LARGE"] == null ? null : Regular.fromJson(json["LARGE"]),
      );

  Map<String, dynamic> toJson() => {
        "THUMBNAIL": thumbnail.toJson(),
        "SMALL": small.toJson(),
        "REGULAR": regular.toJson(),
        "LARGE": large?.toJson(),
      };
}

class Regular {
  String url;
  int width;
  int height;

  Regular({
    required this.url,
    required this.width,
    required this.height,
  });

  factory Regular.fromJson(Map<String, dynamic> json) => Regular(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}

class Ingredient {
  String text;
  double quantity;
  String? measure;
  String food;
  double weight;
  String? foodCategory;
  String foodId;
  String? image;

  Ingredient({
    required this.text,
    required this.quantity,
    required this.measure,
    required this.food,
    required this.weight,
    required this.foodCategory,
    required this.foodId,
    required this.image,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        text: json["text"],
        quantity: json["quantity"]?.toDouble(),
        measure: json["measure"],
        food: json["food"],
        weight: json["weight"]?.toDouble(),
        foodCategory: json["foodCategory"],
        foodId: json["foodId"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "quantity": quantity,
        "measure": measure,
        "food": food,
        "weight": weight,
        "foodCategory": foodCategory,
        "foodId": foodId,
        "image": image,
      };
}

enum MealType { BREAKFAST, LUNCH_DINNER, SNACK }

final mealTypeValues = EnumValues({
  "breakfast": MealType.BREAKFAST,
  "lunch/dinner": MealType.LUNCH_DINNER,
  "snack": MealType.SNACK
});

enum Source { NOT_WITHOUT_SALT, NO_RECIPES, SERIOUS_EATS }

final sourceValues = EnumValues({
  "Not Without Salt": Source.NOT_WITHOUT_SALT,
  "No Recipes": Source.NO_RECIPES,
  "Serious Eats": Source.SERIOUS_EATS
});

class Total {
  Label label;
  double quantity;
  Unit? unit;

  Total({
    required this.label,
    required this.quantity,
    required this.unit,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        label: labelValues.map[json["label"]]!,
        quantity: json["quantity"]?.toDouble(),
        unit: unitValues.map[json["unit"]],
      );

  Map<String, dynamic> toJson() => {
        "label": labelValues.reverse[label],
        "quantity": quantity,
        "unit": unitValues.reverse[unit],
      };
}

// class EdamamLinks {
//   Next? next;

//   EdamamLinks({
//     required this.next,
//   });

//   factory EdamamLinks.fromJson(Map<String, dynamic> json) => EdamamLinks(
//         next: Next.fromJson(json["next"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "next": next.toJson(),
//       };
// }

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
