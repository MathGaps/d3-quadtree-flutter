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

  test(
    'Quadtree.remove(point) removes another non-root point in the quadtree',
    () {
      final q = Quadtree<Point>()..addAll([p00, p11]);
      expect((q..remove(p11)).root, p00.leaf);
      expect(q.extent(), Extent(0, 0, 2, 2));
    },
  );

  test(
    'Quadtree.remove(point) ignores a point not in the quadtree',
    () {
      final q0 = Quadtree<Point>()..add(p00);
      expect((q0..remove(p11)).root, p00.leaf);
      expect(q0.extent(), Extent(0, 0, 1, 1));
    },
  );

  test(
    'Quadtree.remove(point) ignores a coincident point not in the quadtree',
    () {
      // TODO
      final q0 = Quadtree<Point>()..add(p00);
      expect((q0..remove(p11)).root, p00.leaf);
      expect(q0.extent(), Extent(0, 0, 1, 1));
    },
  );

  test(
    'Quadtree.remove(point) removes another point in the quadtree',
    () {
      final q = Quadtree<Point>()..extent(Extent(0, 0, 959, 959));
      q.addAll([
        Point(630, 438),
        Point(715, 464),
        Point(523, 519),
        Point(646, 318),
        Point(434, 620),
        Point(570, 489),
        Point(520, 345),
        Point(459, 443),
        Point(346, 405),
        Point(529, 444),
      ]);
    },
  );
}
