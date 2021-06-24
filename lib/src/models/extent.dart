import 'package:d3_quadtree_flutter/src/interfaces/point.dart';
import 'package:d3_quadtree_flutter/src/models/point.dart';

class Extent {
  const Extent(this.x0, this.y0, this.x1, this.y1);

  final double x0, y0, x1, y1;

  IPoint get lowerBound => Point(x0, y0);
  IPoint get upperBound => Point(x1, y1);

  static const zero = Extent(0, 0, 0, 0);
}
