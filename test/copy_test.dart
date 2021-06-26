import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/test.dart';

import 'add_test.dart';

void main() {
  test("Quadtree.copy returns a copy of this quadtree", () {
    final q0 = Quadtree<Point>()..addAll([p00, p10, p01, p11]);
    expect(q0.copy, q0);
  });
}
