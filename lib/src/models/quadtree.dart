import 'package:d3_quadtree_flutter/src/interfaces/quadtree_node.dart';
import 'package:d3_quadtree_flutter/src/models/leaf.dart';
import 'package:quiver/core.dart';

import '../interfaces/point.dart';
import 'extent.dart';
import 'nodes.dart';

import '../typedefs/accessors.dart';

part '../extensions/x.dart';
part '../extensions/y.dart';
part '../extensions/add.dart';
part '../extensions/cover.dart';
part '../extensions/extent.dart';

class Quadtree<P extends IPoint> implements IInternalNode<P> {
  Quadtree({
    XAccessor? x,
    YAccessor? y,
    Extent? extent,
  })  : this.x = x ?? _defaultX,
        this.y = y ?? _defaultY,
        _extent = extent;

  XAccessor<P> x;
  YAccessor<P> y;
  Extent? _extent;

  Nodes<P>? nodes;
  IQuadtreeNode<P>? root;

  @override
  bool operator ==(Object o) =>
      o is Quadtree<P> &&
      x == o.x &&
      y == o.y &&
      _extent == o._extent &&
      nodes == o.nodes &&
      root == o.root;
  @override
  int get hashCode => hashObjects(
        [x, y, _extent, nodes, root],
      );
}
