import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/test.dart';

final p00 = Point.zero;
final p0909 = Point(0.9, 0.9);
final p0900 = Point(0.9, 0.0);
final p0009 = Point(0.0, 0.9);
final p0404 = Point(0.4, 0.4);

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
    'Quadtree.addAll(point) ignores points with NaN coordinates',
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
}
