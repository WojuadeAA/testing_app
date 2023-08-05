import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/main.dart';

void main() {
  group("Testing App", () {
    testWidgets("Favorties Operation Test", (widgetTester) async {
      await widgetTester.pumpWidget(const TestingApp());
      final iconKeys = [
        'icon_0',
        'icon_1',
        'icon_2',
      ];
      for (var iconKey in iconKeys) {
        await widgetTester.tap(find.byKey(ValueKey(iconKey)).first);
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('Added to favorites.'), findsOneWidget);
      }
      await widgetTester.tap(find.text('Favorites'));
      await widgetTester.pumpAndSettle();
      final removeIconKeys = [
        'remove_icon_0',
        'remove_icon_1',
        'remove_icon_2',
      ];

      for (final iconKey in removeIconKeys) {
        await widgetTester.tap(find.byKey(ValueKey(iconKey)));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('Removed from favorites.'), findsOneWidget);
      }
    });
  });
}
