import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';

final p00 = Point.zero;
final p11 = Point(1, 1);

void main() {
  final q = Quadtree<Point>()..addAll([p00, p11]);
  print(q);
  q..remove(p00);
  print(q);
}
