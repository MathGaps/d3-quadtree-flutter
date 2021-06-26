import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'add_test.dart';

void main() {
  test(
    'Quadtree.visit(callback) visits each node in a quadtree',
    () {
      final q = Quadtree<Point>()..addAll([p00, p10, p01, p11]);
      final List<Extent> results = [];
      q.visit((node, extent) {
        results.add(extent);

        return false;
      });
      expect(results, [
        Extent(0, 0, 2, 2),
        Extent(0, 0, 1, 1),
        Extent(1, 0, 2, 1),
        Extent(0, 1, 1, 2),
        Extent(1, 1, 2, 2),
      ]);
    },
  );
}
