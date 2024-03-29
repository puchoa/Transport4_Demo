import 'package:transport4_demo_app/models/recipe_model.dart';

List<Hit> hitItems = [
  Hit(
      recipe: Recipe(
          uri: "",
          label: "Pizza",
          image: "",
          images: Images(
              thumbnail: Regular(url: "", width: 0, height: 0),
              small: Regular(url: "", width: 0, height: 0),
              regular: Regular(url: "", width: 0, height: 0)),
          source: null,
          url: "",
          shareAs: "",
          recipeYield: 0,
          healthLabels: [],
          ingredientLines: [
            'Pizza dough (store-bought or homemade)',
            'Tomato sauce or marinara sauce',
            'Mozzarella cheese, shredded',
            'Olive oil'
          ],
          ingredients: [],
          calories: 0,
          totalWeight: 0,
          totalTime: 0,
          totalNutrients: {},
          tags: ["pizza", "tasty", "party"],
          totalDaily: {},
          digest: [
            Digest(
                label: Label.ENERGY,
                tag: "",
                schemaOrgTag: null,
                total: 10,
                hasRdi: false,
                daily: 0,
                unit: null),
            Digest(
                label: Label.CARBS,
                tag: "",
                schemaOrgTag: null,
                total: 20,
                hasRdi: false,
                daily: 0,
                unit: null),
            Digest(
                label: Label.PROTEIN,
                tag: "",
                schemaOrgTag: null,
                total: 30,
                hasRdi: false,
                daily: 0,
                unit: null)
          ])),
  Hit(
      recipe: Recipe(
          uri: "",
          label: "Taco",
          image: "",
          images: Images(
              thumbnail: Regular(url: "", width: 0, height: 0),
              small: Regular(url: "", width: 0, height: 0),
              regular: Regular(url: "", width: 0, height: 0)),
          source: null,
          url: "",
          shareAs: "",
          recipeYield: 0,
          healthLabels: [],
          ingredientLines: [],
          ingredients: [],
          calories: 0,
          totalWeight: 0,
          totalTime: 0,
          totalNutrients: {},
          tags: ["taco tuesday", "tasty", "party"],
          totalDaily: {},
          digest: [
            Digest(
                label: Label.ENERGY,
                tag: "",
                schemaOrgTag: null,
                total: 10,
                hasRdi: false,
                daily: 0,
                unit: null),
            Digest(
                label: Label.CARBS,
                tag: "",
                schemaOrgTag: null,
                total: 20,
                hasRdi: false,
                daily: 0,
                unit: null),
            Digest(
                label: Label.PROTEIN,
                tag: "",
                schemaOrgTag: null,
                total: 30,
                hasRdi: false,
                daily: 0,
                unit: null)
          ])),
  Hit(
      recipe: Recipe(
          uri: "",
          label: "Chicken fettuccine Alfredo",
          image: "",
          images: Images(
              thumbnail: Regular(url: "", width: 0, height: 0),
              small: Regular(url: "", width: 0, height: 0),
              regular: Regular(url: "", width: 0, height: 0)),
          source: null,
          url: "",
          shareAs: "",
          recipeYield: 0,
          healthLabels: [],
          ingredientLines: [],
          ingredients: [],
          calories: 0,
          totalWeight: 0,
          totalTime: 0,
          totalNutrients: {},
          tags: ["italian", "delicious", "tasty"],
          totalDaily: {},
          digest: [
            Digest(
                label: Label.ENERGY,
                tag: "",
                schemaOrgTag: null,
                total: 10,
                hasRdi: false,
                daily: 0,
                unit: null),
            Digest(
                label: Label.CARBS,
                tag: "",
                schemaOrgTag: null,
                total: 20,
                hasRdi: false,
                daily: 0,
                unit: null),
            Digest(
                label: Label.PROTEIN,
                tag: "",
                schemaOrgTag: null,
                total: 30,
                hasRdi: false,
                daily: 0,
                unit: null)
          ])),
];

String hitJson =
    '[{"recipe":{"uri":"","label":"Pizza","image":"","images":{"THUMBNAIL":{"url":"","width":0,"height":0},"SMALL":{"url":"","width":0,"height":0},"REGULAR":{"url":"","width":0,"height":0},"LARGE":null},"source":null,"url":"","shareAs":"","yield":0.0,"healthLabels":[],"ingredientLines":["Pizza dough (store-bought or homemade)","Tomato sauce or marinara sauce","Mozzarella cheese, shredded","Olive oil"],"ingredients":[],"calories":0.0,"totalWeight":0.0,"totalTime":0.0,"dishType":[],"totalNutrients":{},"totalDaily":{},"digest":[{"label":"Energy","tag":"","schemaOrgTag":null,"total":10.0,"hasRDI":false,"daily":0.0,"unit":null,"sub":[]},{"label":"Carbs","tag":"","schemaOrgTag":null,"total":20.0,"hasRDI":false,"daily":0.0,"unit":null,"sub":[]},{"label":"Protein","tag":"","schemaOrgTag":null,"total":30.0,"hasRDI":false,"daily":0.0,"unit":null,"sub":[]}],"tags":["pizza","tasty","party"]}},{"recipe":{"uri":"","label":"Taco","image":"","images":{"THUMBNAIL":{"url":"","width":0,"height":0},"SMALL":{"url":"","width":0,"height":0},"REGULAR":{"url":"","width":0,"height":0},"LARGE":null},"source":null,"url":"","shareAs":"","yield":0.0,"healthLabels":[],"ingredientLines":[],"ingredients":[],"calories":0.0,"totalWeight":0.0,"totalTime":0.0,"dishType":[],"totalNutrients":{},"totalDaily":{},"digest":[{"label":"Energy","tag":"","schemaOrgTag":null,"total":10.0,"hasRDI":false,"daily":0.0,"unit":null,"sub":[]},{"label":"Carbs","tag":"","schemaOrgTag":null,"total":20.0,"hasRDI":false,"daily":0.0,"unit":null,"sub":[]},{"label":"Protein","tag":"","schemaOrgTag":null,"total":30.0,"hasRDI":false,"daily":0.0,"unit":null,"sub":[]}],"tags":["taco tuesday","tasty","party"]}},{"recipe":{"uri":"","label":"Chicken fettuccine Alfredo","image":"","images":{"THUMBNAIL":{"url":"","width":0,"height":0},"SMALL":{"url":"","width":0,"height":0},"REGULAR":{"url":"","width":0,"height":0},"LARGE":null},"source":null,"url":"","shareAs":"","yield":0.0,"healthLabels":[],"ingredientLines":[],"ingredients":[],"calories":0.0,"totalWeight":0.0,"totalTime":0.0,"dishType":[],"totalNutrients":{},"totalDaily":{},"digest":[{"label":"Energy","tag":"","schemaOrgTag":null,"total":10.0,"hasRDI":false,"daily":0.0,"unit":null,"sub":[]},{"label":"Carbs","tag":"","schemaOrgTag":null,"total":20.0,"hasRDI":false,"daily":0.0,"unit":null,"sub":[]},{"label":"Protein","tag":"","schemaOrgTag":null,"total":30.0,"hasRDI":false,"daily":0.0,"unit":null,"sub":[]}],"tags":["italian","delicious","tasty"]}}]';
