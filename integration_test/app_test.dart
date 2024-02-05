import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:transport4_demo_app/main.dart' as app;
import 'package:transport4_demo_app/screens/grocery_list.dart';
import 'package:transport4_demo_app/screens/shopping_list.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Create item', () {
    bool debug = true;

    final createButton = find.byKey(const Key("createButton"));
    final floatingActionButton =
        find.byKey(const Key("addFloatingActionButton"));
    final textfield = find.byKey(const Key("textfield"));
    final backButton = find.byKey(const Key("backButton"));
    final cancelButton = find.byKey(const Key("cancelButton"));
    final discardButton = find.byKey(const Key("discardButton"));
    final saveButton = find.byKey(const Key("saveButton"));

    testWidgets("Check alert dialog", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.tap(createButton);
      if (debug) Future.delayed(const Duration(seconds: 2));

      await tester.pumpAndSettle();
      expect(find.byType(ShoppingList), findsOneWidget);

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.tap(floatingActionButton);
      await tester.pumpAndSettle();

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.enterText(textfield, "cheese");
      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.pumpAndSettle();
      expect(find.text("cheese"), findsOne);

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.enterText(textfield, "eggs");
      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.pumpAndSettle();
      expect(find.text("eggs"), findsOne);

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.enterText(textfield, "ham");
      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.pumpAndSettle();
      expect(find.text("ham"), findsOne);

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOne);
      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.tap(cancelButton);
      await tester.pumpAndSettle();

      expect(find.byType(ShoppingList), findsOneWidget);

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      await tester.tap(discardButton);
      await tester.pumpAndSettle();

      expect(find.byType(GroceryList), findsOne);
    });

    testWidgets("Save item", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text("Add items to your list"), findsOneWidget);
      expect(find.text("Grocery List"), findsOneWidget);
      expect(find.text("Create List"), findsOneWidget);

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.tap(createButton);
      if (debug) Future.delayed(const Duration(seconds: 2));

      await tester.pumpAndSettle();
      expect(find.byType(ShoppingList), findsOneWidget);

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.tap(floatingActionButton);
      await tester.pumpAndSettle();

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.enterText(textfield, "cheese");
      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.pumpAndSettle();
      expect(find.text("cheese"), findsOne);

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.enterText(textfield, "eggs");
      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.pumpAndSettle();
      expect(find.text("eggs"), findsOne);

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.enterText(textfield, "ham");
      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.pumpAndSettle();
      expect(find.text("ham"), findsOne);

      if (debug) Future.delayed(const Duration(seconds: 2));
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      if (debug) Future.delayed(const Duration(seconds: 2));
      expect(find.text("New List"), findsOne);
      expect(find.text("Grocery List"), findsOneWidget);
      expect(find.text("Create List"), findsOneWidget);
    });
  });
}
