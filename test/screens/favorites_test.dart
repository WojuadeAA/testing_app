import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screens/favorites.dart';

late Favorites favoritesList;

Widget createFavoritesScreen() {
  final favorites = Favorites();
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<Favorites>.value(value: favorites),
    ],
    child: const MaterialApp(
      home: FavoritesPage(),
    ),
  );
}

void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group("Test Favorites page", () {
    testWidgets("Test if ListViewShows Up", (widgetTester) async {
      await widgetTester.pumpWidget(createFavoritesScreen());
      addItems();
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });
  });

  ///This test verifies whether an item disappears when the close (remove) button is pressed.
  testWidgets("Testing Remove Button", (widgetTester) async {
    await widgetTester.pumpWidget(createFavoritesScreen());
    addItems();
    await widgetTester.pumpAndSettle();
    final totalItems = widgetTester.widgetList(find.byType(ListTile)).length;
    await widgetTester.tap(find.byIcon(Icons.close).first);
    await widgetTester.pumpAndSettle();
    expect(widgetTester.widgetList(find.byIcon(Icons.close)).length,
        lessThan(totalItems));
    expect(find.text("Removed from favorites"), findsOneWidget);
  });
}
