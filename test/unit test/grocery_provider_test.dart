import 'package:flutter_test/flutter_test.dart';
import 'package:transport4_demo_app/providers/grocery_list_provider.dart';
import 'grocery_items.dart';

void main() {
  group('GroceryList Provider Functions', () {
    test('adding grocery - length should increment', () {
      final provider = GroceryListProvider();

      provider.addGrocery(grocery: groceries[0]);

      expect(provider.groceryList.length, equals(1));

      provider.addGrocery(grocery: groceries[1]);

      expect(provider.groceryList.length, equals(2));

      provider.addGrocery(grocery: groceries[1]);
      provider.addGrocery(grocery: groceries[1]);
      provider.addGrocery(grocery: groceries[1]);

      expect(provider.groceryList.length, equals(5));
    });

    test('removing grocery - length should decrement', () {
      final provider = GroceryListProvider();

      provider.addGrocery(grocery: groceries[1]);
      provider.addGrocery(grocery: groceries[1]);
      provider.addGrocery(grocery: groceries[1]);

      expect(provider.groceryList.length, equals(3));

      provider.removeItem(index: 0);
      expect(provider.groceryList.length, equals(2));

      provider.removeItem(index: 0);
      expect(provider.groceryList.length, equals(1));
    });

    test('tags should not have duplicates', () {
      final provider = GroceryListProvider();

      provider.addGrocery(grocery: groceries[1]);
      provider.addGrocery(grocery: groceries[1]);
      provider.addGrocery(grocery: groceries[1]);
      provider.addGrocery(grocery: groceries[2]);
      provider.addGrocery(grocery: groceries[2]);
      provider.addGrocery(grocery: groceries[2]);
      provider.addGrocery(grocery: groceries[0]);
      provider.addGrocery(grocery: groceries[0]);
      provider.addGrocery(grocery: groceries[0]);

      List<String> allTags = provider.allTags();

      expect(allTags.length, equals(6));
    });
  });
}
