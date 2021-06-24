import 'package:d3_quadtree_flutter/src/models/quadtree.dart';
import 'package:d3_quadtree_flutter/src/typedefs/accessors.dart';
import 'package:test/test.dart';

void main() {
  test('Quadtree.x(x) sets the x-accessor used by Quadtree.add', () {
    final q = Quadtree()..x = x;
  });
}

XAccessor x = (point) => point.x;
