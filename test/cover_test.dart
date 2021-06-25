import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Quadtree.cover(x, y) sets a trivial extent if the extent was undefined',
    () {
      expect(
        (Quadtree<Point>()..cover(1, 2)).extent(),
        Extent(1, 2, 2, 3),
      );
    },
  );

  test(
    'Quadtree.cover(x, y) sets a non-trivial squarified and centered extent if the extent was trivial',
    () {
      expect(
        (Quadtree<Point>()..cover(0, 0)..cover(1, 2)).extent(),
        Extent(0, 0, 4, 4),
      );
    },
  );

  test(
    'Quadtree.cover(x, y) ignores invalid points',
    () {
      expect(
        (Quadtree<Point>()..cover(0, 0)..cover(double.nan, 2)).extent(),
        Extent(0, 0, 1, 1),
      );
    },
  );

  test(
    'Quadtree.cover(x, y) repeatedly doubles the existing extent if the extent was non-trivial',
    () {
      Quadtree<Point> base() => Quadtree<Point>()..cover(0, 0)..cover(2, 2);

      expect(
        (base()..cover(-1, -1)).extent(),
        Extent(-4, -4, 4, 4),
      );
      expect(
        (base()..cover(1, -1)).extent(),
        Extent(0, -4, 8, 4),
      );
      expect(
        (base()..cover(3, -1)).extent(),
        Extent(0, -4, 8, 4),
      );
      expect(
        (base()..cover(3, 1)).extent(),
        Extent(0, 0, 4, 4),
      );
      expect(
        (base()..cover(3, 3)).extent(),
        Extent(0, 0, 4, 4),
      );
      expect(
        (base()..cover(1, 3)).extent(),
        Extent(0, 0, 4, 4),
      );
      expect(
        (base()..cover(-1, 3)).extent(),
        Extent(-4, 0, 4, 8),
      );
      expect(
        (base()..cover(-1, 1)).extent(),
        Extent(-4, 0, 4, 8),
      );
      expect(
        (base()..cover(-3, -3)).extent(),
        Extent(-4, -4, 4, 4),
      );
      expect(
        (base()..cover(3, -3)).extent(),
        Extent(0, -4, 8, 4),
      );
      expect(
        (base()..cover(5, -3)).extent(),
        Extent(0, -4, 8, 4),
      );
      expect(
        (base()..cover(5, 3)).extent(),
        Extent(0, 0, 8, 8),
      );
      expect(
        (base()..cover(5, 5)).extent(),
        Extent(0, 0, 8, 8),
      );
      expect(
        (base()..cover(3, 5)).extent(),
        Extent(0, 0, 8, 8),
      );
      expect(
        (base()..cover(-3, 5)).extent(),
        Extent(-4, 0, 4, 8),
      );
      expect(
        (base()..cover(-3, 3)).extent(),
        Extent(-4, 0, 4, 8),
      );
    },
  );

  test(
    'Quadtree.cover(x, y) repeatedly wraps the root node if it has children',
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
      expect(
        (q.copy..cover(3, 3)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            nw: Point.zero.leaf,
            se: Point(2, 2).leaf,
          ),
      );
      expect(
        (q.copy..cover(-1, 3)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            ne: Quadtree<Point>()
              ..nodes = Nodes(
                nw: Point.zero.leaf,
                se: Point(2, 2).leaf,
              ),
          ),
      );
      expect(
        (q.copy..cover(3, -1)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            sw: Quadtree<Point>()
              ..nodes = Nodes(
                nw: Point.zero.leaf,
                se: Point(2, 2).leaf,
              ),
          ),
      );
      expect(
        (q.copy..cover(5, 5)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            nw: Quadtree<Point>()
              ..nodes = Nodes(
                nw: Point.zero.leaf,
                se: Point(2, 2).leaf,
              ),
          ),
      );
      expect(
        (q.copy..cover(-3, 5)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            ne: Quadtree<Point>()
              ..nodes = Nodes(
                nw: Point.zero.leaf,
                se: Point(2, 2).leaf,
              ),
          ),
      );
      expect(
        (q.copy..cover(5, -3)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            sw: Quadtree<Point>()
              ..nodes = Nodes(
                nw: Point.zero.leaf,
                se: Point(2, 2).leaf,
              ),
          ),
      );
      expect(
        (q.copy..cover(-3, -3)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            se: Quadtree<Point>()
              ..nodes = Nodes(
                nw: Point.zero.leaf,
                se: Point(2, 2).leaf,
              ),
          ),
      );
    },
  );
  test(
    'Quadtree.cover(x, y) does not wrap the root node if it is a leaf',
    () {
      final q = Quadtree<Point>()
        ..cover(0, 0)
        ..add(Point(2, 2));
      expect(
        q.root,
        Point(2, 2).leaf,
      );
      expect(
        (q.copy..cover(3, 3)).root,
        Point(2, 2).leaf,
      );
      expect(
        (q.copy..cover(-1, 3)).root,
        Point(2, 2).leaf,
      );
      expect(
        (q.copy..cover(3, -1)).root,
        Point(2, 2).leaf,
      );
      expect(
        (q.copy..cover(-1, -1)).root,
        Point(2, 2).leaf,
      );
      expect(
        (q.copy..cover(5, 5)).root,
        Point(2, 2).leaf,
      );
      expect(
        (q.copy..cover(-3, 5)).root,
        Point(2, 2).leaf,
      );
      expect(
        (q.copy..cover(5, -3)).root,
        Point(2, 2).leaf,
      );
      expect(
        (q.copy..cover(-3, -3)).root,
        Point(2, 2).leaf,
      );
    },
  );
  test(
    'Quadtree.cover(x, y) does not wrap the root node if it is undefined',
    () {
      final q = Quadtree<Point>()..cover(0, 0)..cover(2, 2);
      expect(
        q.root,
        null,
      );
      expect((q.copy..cover(3, 3)).root, null);
      expect((q.copy..cover(-1, 3)).root, null);
      expect((q.copy..cover(3, -1)).root, null);
      expect((q.copy..cover(-1, -1)).root, null);
      expect((q.copy..cover(5, 5)).root, null);
      expect((q.copy..cover(-3, 5)).root, null);
      expect((q.copy..cover(5, -3)).root, null);
      expect((q.copy..cover(-3, -3)).root, null);
    },
  );

  test(
    'Quadtree.cover() does not crash on huge values',
    () {
      // todo
    },
  );
}
