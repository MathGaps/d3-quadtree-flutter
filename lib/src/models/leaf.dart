import 'package:d3_quadtree_flutter/src/interfaces/point.dart';
import 'package:d3_quadtree_flutter/src/interfaces/quadtree_node.dart';
import 'package:quiver/core.dart';

class Leaf<P extends IPoint> implements ILeafNode<P> {
  Leaf(this._point);

  final P _point;
  @override
  ILeafNode<P>? next;

  @override
  P get point => _point;

  @override
  double get x => _point.x;
  set x(double x) => _point.x = x;

  @override
  double get y => _point.y;
  set y(double y) => _point.y = y;

  @override
  bool get isNaN => _point.isNaN;

  @override
  Leaf<P> get copy => Leaf(_point.copy as P);

  @override
  bool operator ==(Object o) =>
      o is Leaf<P> && _point == o.point && next == o.next;
  @override
  int get hashCode => hash2(_point, next);
  @override
  String toString() => 'Leaf($_point)';
}
