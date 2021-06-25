import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/test.dart';

final p00 = Point.zero;
final p0909 = Point(0.9, 0.9);
final p0900 = Point(0.9, 0.0);
final p0009 = Point(0.0, 0.9);
final p0404 = Point(0.4, 0.4);
final p10 = Point(1, 0);
final p01 = Point(0, 1);
final p11 = Point(1, 1);

void main() {
  test(
    'Quadtree.add(point) creates a new point and adds it to the quadtree',
    () {
      final q = Quadtree<Point>();

      expect((q..add(p00)).root, equals(Leaf(p00)));
      expect(
        (q..add(p0909)).root,
        equals(
          Quadtree<Point>()
            ..nodes = Nodes<Point>(
              nw: Leaf(p00),
              se: Leaf(p0909),
            ),
        ),
      );
      expect(
        (q..add(p0900)).root,
        equals(
          Quadtree<Point>()
            ..nodes = Nodes<Point>(
              nw: p00.leaf,
              ne: p0900.leaf,
              se: p0909.leaf,
            ),
        ),
      );
      expect(
        (q..add(p0009)).root,
        equals(
          Quadtree<Point>()
            ..nodes = Nodes<Point>(
              nw: p00.leaf,
              ne: p0900.leaf,
              sw: p0009.leaf,
              se: p0909.leaf,
            ),
        ),
      );
      expect(
        (q..add(p0404)).root,
        equals(
          Quadtree<Point>()
            ..nodes = Nodes<Point>(
              nw: Quadtree<Point>()
                ..nodes = Nodes(nw: p00.leaf, se: p0404.leaf),
              ne: p0900.leaf,
              sw: p0009.leaf,
              se: p0909.leaf,
            ),
        ),
      );
    },
  );

  test(
    'Quaddtree.add(point) handles points being on the perimeter of the quadtree bounds',
    () {
      final q = Quadtree<Point>()..extent(Extent(0, 0, 1, 1));
      expect((q..add(p00)).root, p00.leaf);
      expect(
        (q..add(p11)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            nw: p00.leaf,
            se: p11.leaf,
          ),
      );
      expect(
        (q..add(p10)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            nw: p00.leaf,
            ne: p10.leaf,
            se: p11.leaf,
          ),
      );
      expect(
        (q..add(p01)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            nw: p00.leaf,
            ne: p10.leaf,
            sw: p01.leaf,
            se: p11.leaf,
          ),
      );
    },
  );

  test(
    'Quadtree.add(point) handles points being to the top of the quadtree bounds',
    () {
      final q = Quadtree<Point>()..extent(Extent(0, 0, 2, 2));
      expect((q..add(Point(1, -1))).extent(), Extent(0, -4, 8, 4));
    },
  );

  test(
    'Quadtree.add(point) handles points being to the right of the quadtree bounds',
    () {
      final q = Quadtree<Point>()..extent(Extent(0, 0, 2, 2));
      expect((q..add(Point(3, 1))).extent(), Extent(0, 0, 4, 4));
    },
  );

  test(
    'Quadtree.add(point) handles points being to the bottom of the quadtree bounds',
    () {
      final q = Quadtree<Point>()..extent(Extent(0, 0, 2, 2));
      expect((q..add(Point(1, 3))).extent(), Extent(0, 0, 4, 4));
    },
  );

  test(
    'Quadtree.add(point) handles points being to the left of the quadtree bounds',
    () {
      final q = Quadtree<Point>()..extent(Extent(0, 0, 2, 2));
      expect((q..add(Point(-1, 1))).extent(), Extent(-4, 0, 4, 8));
    },
  );

  test(
    'Quadtree.add(point) handles coincident points by creating a linked list',
    () {
      final q = Quadtree<Point>()..extent(Extent(0, 0, 1, 1));
      expect((q..add(p00)).root, p00.leaf);
      expect(
        (q..add(p10)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            nw: p00.leaf,
            ne: p10.leaf,
          ),
      );
      expect(
        (q..add(p01)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            nw: p00.leaf,
            ne: p10.leaf,
            sw: p01.leaf,
          ),
      );
      expect(
        (q..add(p01)).root,
        Quadtree<Point>()
          ..nodes = Nodes(
            nw: p00.leaf,
            ne: p10.leaf,
            sw: p01.leaf..next = p01.leaf,
          ),
      );
    },
  );

  test(
    'Quadtree.add(point) implicitly defines trivial bounds for the first point',
    () {
      final q = Quadtree<Point>()..add(Point(1, 2));
      expect(q.extent(), Extent(1, 2, 2, 3));
      expect(q.root, Point(1, 2).leaf);
    },
  );
}
