import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/test.dart';

void main() {
  test('Quadtree.x(x) sets the x-accessor used by Quadtree.add', () {
    final q = Quadtree()
      ..x = x
      ..add(Point(1, 2));

    expect(q.extent(), equals(Extent(1, 2, 2, 3)));
  });
}

XAccessor x = (point) => point.x;
