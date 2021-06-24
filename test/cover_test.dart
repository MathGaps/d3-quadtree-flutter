import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Quadtree.cover(point) sets a trivial extent if the extent was undefined',
    () {
      expect(
        (Quadtree<Point>()..cover(Point(1, 2))).extent(),
        Extent(1, 2, 2, 3),
      );
    },
  );

  test(
    'Quadtree.cover(point) sets a non-trivial squarified and centered extent if the extent was trivial',
    () {
      expect(
        (Quadtree<Point>()..cover(Point.zero)..cover(Point(1, 2))).extent(),
        Extent(0, 0, 4, 4),
      );
    },
  );

  test(
    'Quadtree.cover(point) ignores invalid points',
    () {
      expect(
        (Quadtree<Point>()..cover(Point.zero)..cover(Point(double.nan, 2)))
            .extent(),
        Extent(0, 0, 1, 1),
      );
    },
  );

  test(
    'Quadtree.cover(point) repeatedly doubles the existing extent if the extent was non-trivial',
    () {
      Quadtree<Point> base() =>
          Quadtree<Point>()..cover(Point.zero)..cover(Point(2, 2));

      expect(
        (base()..cover(Point(-1, -1))).extent(),
        Extent(-4, -4, 4, 4),
      );
      expect(
        (base()..cover(Point(1, -1))).extent(),
        Extent(0, -4, 8, 4),
      );
      expect(
        (base()..cover(Point(3, -1))).extent(),
        Extent(0, -4, 8, 4),
      );
    },
  );
}
