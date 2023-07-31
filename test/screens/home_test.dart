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

    // testWidgets('renders item tiles', (tester) async {
    //   await tester.pumpWidget(createHomeScreen());

    //   expect(find.byType(ItemTile, skipOffstage: true), findsNWidgets(8));
    // });

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
}
