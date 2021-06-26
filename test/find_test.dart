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
}
