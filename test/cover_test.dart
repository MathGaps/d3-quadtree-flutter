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
  });
}
