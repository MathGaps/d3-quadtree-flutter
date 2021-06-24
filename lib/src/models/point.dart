import 'package:d3_quadtree_flutter/src/interfaces/point.dart';

class Point implements IPoint {
  Point(this.x, this.y);

  @override
  double x;
  @override
  double y;

  @override
  bool get isNaN => x.isNaN || y.isNaN;
}
