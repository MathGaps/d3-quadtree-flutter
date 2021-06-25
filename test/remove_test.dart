import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/test.dart';

final p00 = Point.zero;
final p11 = Point(1, 1);

void main() {
  test(
    'Quadtree.remove(point) removes a point and returns the quadtree',
    () {
      final q = Quadtree<Point>()..add(p00);
      expect(q.root, p00.leaf);
      expect((q..remove(p00)).root, null);
    },
  );

  test(
    'Quadtree.remove(point) removes the only point in the quadtree',
    () {
      final q = Quadtree<Point>()..add(p11);
      expect((q..remove(p11)).root, null);
      expect(q.extent(), Extent(1, 1, 2, 2));
      expect(q.root, null);
    },
  );

  test(
    'Quadtree.remove(point) removes a first coincident point at the root in the quadtree',
    () {
      //! This isn't actually validating this edge case
      final q = Quadtree<Point>()..addAll([p11, p11]);
      expect((q..remove(p11)).root, p11.leaf);
      expect(q.extent(), Extent(1, 1, 2, 2));
    },
  );

  test(
    'Quadtree.remove(point) removes a non-root point in the quadtree',
    () {
      final q = Quadtree<Point>()..addAll([p00, p11]);
      expect((q..remove(p00)).root, p11.leaf);
      expect(q.extent(), Extent(0, 0, 2, 2));
    },
  );
}
