import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/test.dart';

final p00 = Point(0, 0);
final p0909 = Point(0.9, 0.9);

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
  });
}
