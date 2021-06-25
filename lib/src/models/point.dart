import 'package:d3_quadtree_flutter/src/interfaces/point.dart';
import 'package:quiver/core.dart';

import '../../d3_quadtree_flutter.dart';

class Point implements IPoint {
  Point(this.x, this.y);

  @override
  double x;
  @override
  double y;

  @override
  bool get isNaN => x.isNaN || y.isNaN;

  static Point zero = Point(0, 0);
  Leaf<Point> get leaf => Leaf(this);

  @override
  Point get copy => Point(x, y);

  @override
  bool operator ==(Object o) => o is Point && x == o.x && y == o.y;
  @override
  int get hashCode => hash2(x, y);
  @override
  String toString() => '($x, $y)';
}
