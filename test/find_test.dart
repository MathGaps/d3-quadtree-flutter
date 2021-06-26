import 'dart:math';

import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test(
    'Quadtree.find(x, y) returns the closest point to the given (x, y)',
    () {
      const int dx = 17, dy = 17;
      final q = Quadtree<Point>();
      for (int i = 0; i < dx * dy; ++i)
        q.add(Point(
          (i % dx).toDouble(),
          (i ~/ dx).toDouble(),
        ));
      expect(q.find(0.1, 0.1), Point(0, 0));
      expect(q.find(7.1, 7.1), Point(7, 7));
      expect(q.find(0.1, 15.9), Point(0, 16));
      expect(q.find(15.9, 15.9), Point(16, 16));
    },
  );

  test(
    'Quadtree.find(x, y, radius) returns the closest point within the search radius to the given (x, y)',
    () {
      final q = Quadtree<Point>()
        ..addAll([
          Point.zero,
          Point(100, 0),
          Point(0, 100),
          Point(100, 100),
        ]);
      expect(q.find(20, 20, double.infinity), Point.zero);
      expect(q.find(20, 20, 20 * sqrt2 + 1e-6), Point.zero);
      expect(q.find(20, 20, 20 * sqrt2 - 1e-6), null);
      expect(q.find(0, 20, 20 + 1e-6), Point.zero);
      expect(q.find(0, 20, 20 - 1e-6), null);
      expect(q.find(20, 0, 20 + 1e-6), Point.zero);
      expect(q.find(20, 0, 20 - 1e-6), null);
    },
  );

  test(
    'Quadtree.find(x, y, null) treats the given radius as Infinity',
    () {
      final q = Quadtree<Point>()
        ..addAll([
          Point.zero,
          Point(100, 0),
          Point(0, 100),
          Point(100, 100),
        ]);
      expect(q.find(20, 20, null), Point.zero);
    },
  );
}
