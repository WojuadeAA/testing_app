

import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/models/favorites.dart';

void main() {
  group('Favorites', () {
   late Favorites favorites;

    setUp(() {
      favorites = Favorites();
    });

    test('adding item to favorites', () {
      favorites.add(1);
      expect(favorites.items.length, 1);
      expect(favorites.items[0], 1);
    });
    test('A new item should be added', () {
      var number = 35;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
    });   

    test('removing item from favorites', () {
      favorites.add(1);
      favorites.remove(1);
      expect(favorites.items.length, 0);
    });
  });
}