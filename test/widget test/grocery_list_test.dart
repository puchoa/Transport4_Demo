import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:transport4_demo_app/main.dart';
import '../unit test/web_items.dart';
import 'grocery_list_test.mocks.dart';

void main() {
  final mockClient = MockClient();

  when(mockClient.get(Uri.parse(
          "https://api.edamam.com/api/recipes/v2?type=public&app_id=30f3b536&app_key=63b5ae380f030b8d90929b1b6db216b2&ingr=5-10&time=5-60&imageSize=LARGE&random=true")))
      .thenAnswer((_) async => http.Response(hitJson, 200));

  testWidgets('Check home is empty', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyApp()));
    await tester.pump();

    expect(find.text("Add items to your list"), findsOneWidget);
    expect(find.text("Grocery List"), findsOneWidget);
    expect(find.text("Create List"), findsOneWidget);
  });

  testWidgets('Create new list', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyApp()));

    final createButton = find.byKey(const Key("createButton"));
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    expect(find.text("New List"), findsOneWidget);
    expect(find.text("Save"), findsOneWidget);

    final floatingActionButton =
        find.byKey(const Key("addFloatingActionButton"));

    await tester.tap(floatingActionButton);
    await tester.pumpAndSettle();

    final textfield = find.byKey(const Key("textfield"));
    await tester.enterText(textfield, "cheese");
    await tester.pumpAndSettle();

    expect(find.text("cheese"), findsOneWidget);

    await tester.enterText(textfield, "eggs");
    await tester.pumpAndSettle();

    expect(find.text("eggs"), findsOneWidget);

    await tester.enterText(textfield, "eggs");
    await tester.pumpAndSettle();

    expect(find.text("eggs"), findsWidgets);
  });
}
