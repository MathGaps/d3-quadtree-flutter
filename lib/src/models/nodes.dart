import 'dart:collection';

import 'package:d3_quadtree_flutter/src/interfaces/point.dart';
import 'package:d3_quadtree_flutter/src/interfaces/quadtree_node.dart';

class Nodes<P extends IPoint> with IterableMixin<IQuadtreeNode<P>?> {
  Nodes({
    this.nw,
    this.ne,
    this.sw,
    this.se,
  });

  IQuadtreeNode<P>? nw, ne, sw, se;

  bool get anyNonNull => nw != null || ne != null || sw != null || se != null;

  @override
  Iterator<IQuadtreeNode<P>?> get iterator => [nw, ne, sw, se].iterator;

  IQuadtreeNode<P>? operator [](int i) {
    if (i < 0 || i > 5) throw RangeError.range(i, 0, 4);
    return toList()[i];
  }

  void operator []=(int i, IQuadtreeNode<P>? node) {
    if (i < 0 || i > 5) throw RangeError.range(i, 0, 4);
    switch (i) {
      case 0:
        nw = node;
        break;
      case 1:
        ne = node;
        break;
      case 2:
        sw = node;
        break;
      case 3:
        se = node;
        break;
    }
  }
}
