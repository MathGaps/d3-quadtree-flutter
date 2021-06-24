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
      expect(
        (base()..cover(Point(3, 1))).extent(),
        Extent(0, 0, 4, 4),
      );
      expect(
        (base()..cover(Point(3, 3))).extent(),
        Extent(0, 0, 4, 4),
      );
      expect(
        (base()..cover(Point(1, 3))).extent(),
        Extent(0, 0, 4, 4),
      );
      expect(
        (base()..cover(Point(-1, 3))).extent(),
        Extent(-4, 0, 4, 8),
      );
      expect(
        (base()..cover(Point(-1, 1))).extent(),
        Extent(-4, 0, 4, 8),
      );
      expect(
        (base()..cover(Point(-3, -3))).extent(),
        Extent(-4, -4, 4, 4),
      );
      expect(
        (base()..cover(Point(3, -3))).extent(),
        Extent(0, -4, 8, 4),
      );
      expect(
        (base()..cover(Point(5, -3))).extent(),
        Extent(0, -4, 8, 4),
      );
      expect(
        (base()..cover(Point(5, 3))).extent(),
        Extent(0, 0, 8, 8),
      );
      expect(
        (base()..cover(Point(5, 5))).extent(),
        Extent(0, 0, 8, 8),
      );
      expect(
        (base()..cover(Point(3, 5))).extent(),
        Extent(0, 0, 8, 8),
      );
      expect(
        (base()..cover(Point(-3, 5))).extent(),
        Extent(-4, 0, 4, 8),
      );
      expect(
        (base()..cover(Point(-3, 3))).extent(),
        Extent(-4, 0, 4, 8),
      );
    },
  );

  test(
    'Quadtree.cover(point) repeatedly wraps the root node if it has children',
    () {
      final q = Quadtree<Point>()..add(Point.zero)..add(Point(2, 2));
      expect(
        q.root,
        Quadtree<Point>()
          ..nodes = Nodes(
            nw: Point.zero.leaf,
            se: Point(2, 2).leaf,
          ),
      );
    },
  );
}
