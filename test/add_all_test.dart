import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/test.dart';

import 'add_test.dart';

void main() {
  test(
    'Quadtree.addAll(points) creates new points and adds them to the quadtree',
    () {
      final q = Quadtree<Point>();
      expect(
        (q..addAll([p00, p0909, p0900, p0009, p0404])).root,
        equals(
          Quadtree<Point>()
            ..nodes = Nodes<Point>(
              nw: Quadtree<Point>()
                ..nodes = Nodes<Point>(
                  nw: p00.leaf,
                  se: p0404.leaf,
                ),
              ne: p0900.leaf,
              sw: p0009.leaf,
              se: p0909.leaf,
            ),
        ),
      );
    },
  );

  test(
    'Quadtree.addAll(points) ignores points with NaN coordinates',
    () {
      final q = Quadtree<Point>();
      expect(
        (q..addAll([Point(double.nan, 0), Point(0, double.nan)])).root,
        null,
      );
      expect(
        q.extent(),
        null,
      );
      expect(
        (q..addAll([p00, p0909])).root,
        Quadtree<Point>()..nodes = Nodes(nw: p00.leaf, se: p0909.leaf),
      );
      expect(
        (q..addAll([Point(double.nan, 0), Point(0, double.nan)])).root,
        Quadtree<Point>()..nodes = Nodes(nw: p00.leaf, se: p0909.leaf),
      );
      expect(q.extent(), Extent(0, 0, 1, 1));
    },
  );

  test(
    'Quadtree.addAll(points) correctly handles the empty array',
    () {
      final q = Quadtree<Point>();
      expect((q..addAll([])).root, null);
      expect(q.extent(), null);
      expect(
        (q..addAll([p00, Point(1, 1)])).root,
        Quadtree<Point>()..nodes = Nodes(nw: p00.leaf, se: Point(1, 1).leaf),
      );
      expect(
        (q..addAll([])).root,
        Quadtree<Point>()..nodes = Nodes(nw: p00.leaf, se: Point(1, 1).leaf),
      );
      expect(
        q.extent(),
        Extent(0, 0, 2, 2),
      );
    },
  );

  test(
    'Quadtree.addAll(points) computes the extent of the data before adding',
    () {
      final q = Quadtree<Point>()..addAll([p0404, p00, p0909]);
      expect(
        q.root,
        Quadtree<Point>()
          ..nodes = Nodes(
            nw: Quadtree<Point>()
              ..nodes = Nodes(
                nw: p00.leaf,
                se: p0404.leaf,
              ),
            se: p0909.leaf,
          ),
      );
    },
  );
}
