import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screens/home.dart';

Widget createHomeScreen() {
  final favorites = Favorites();
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<Favorites>.value(value: favorites),
    ],
    child: const MaterialApp(
      home: HomePage(),
    ),
  );
}

void main() {
  group('HomePage', () {
    testWidgets('renders app bar title', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      expect(find.text('Testing Sample'), findsOneWidget);
    });

    testWidgets('renders correct number of items in ListView.builder',
        (tester) async {
      const itemCount = 13;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              itemCount: itemCount,
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  ListTile(title: Text('Item $index')),
            ),
          ),
        ),
      );
      expect(
          find.byType(ListTile, skipOffstage: false), findsNWidgets(itemCount));
    });
    testWidgets('adds item to favorites when icon is pressed', (tester) async {
      final favorites = Favorites();
      await tester.pumpWidget(createHomeScreen());

      await tester.tap(find.byKey(const Key('icon_0')));
      await tester.pump();

      expect(favorites.items, contains(0));
    });

    testWidgets('removes item from favorites when icon is pressed',
        (tester) async {
      final favorites = Favorites();
      favorites.add(0);
      await tester.pumpWidget(createHomeScreen());

      await tester.tap(find.byKey(const Key('icon_0')));
      await tester.pump();

      expect(favorites.items, isNot(contains(0)));
    });
  });

  group("Codelab homepage widgets tests", () {
    testWidgets("Test Scrolling", (widgetTester) async {
      await widgetTester.pumpWidget(createHomeScreen());
      expect(find.text('Item 0'), findsOneWidget);
      await widgetTester.fling(
          find.byType(ListView), const Offset(0, -200), 3000);
      await widgetTester.pumpAndSettle();
      expect(find.text('Item 0'), findsNothing);
    });
  });

  ///This test Verifies that tapping the IconButton changes from Icons.favorite_border
  ///to Icons.favorite and back again.
  testWidgets("Testing IconButton", (widgetTester) async {
    await widgetTester.pumpWidget(createHomeScreen());
    expect(find.byIcon(Icons.favorite), findsNothing);
    await widgetTester.tap(find.byIcon(Icons.favorite_border).first);
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('Added to favorites.'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await widgetTester.tap(find.byIcon(Icons.favorite).first);
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('Removed from favorites.'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
  });
}
