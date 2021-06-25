import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/test.dart';

final p00 = Point.zero;
final p0909 = Point(0.9, 0.9);
final p0900 = Point(0.9, 0.0);
final p0009 = Point(0.0, 0.9);
final p0404 = Point(0.4, 0.4);

void main() {
  test('Quadtree.add(point) creates a new point and adds it to the quadtree',
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
  });
}
