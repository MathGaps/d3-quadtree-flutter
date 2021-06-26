import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/expect.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Quadtree.size() returns the number of points in the quadtree',
    () {
      final q = Quadtree<Point>();
      expect(q.size(), 0);
      q..add(Point.zero)..add(Point(1, 2));
      expect(q.size(), 2);
    },
  );

  test(
    'Quadtree.size() correctly counts coincident nodes',
    () {
      final q = Quadtree<Point>();
      q..add(Point.zero)..add(Point.zero);
      expect(q.size(), 2);
    },
  );
}
