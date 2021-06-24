import 'package:d3_quadtree_flutter/src/interfaces/quadtree_node.dart';
import 'package:d3_quadtree_flutter/src/models/leaf.dart';

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
    this.extent,
  })  : this.x = x ?? _defaultX,
        this.y = y ?? _defaultY;

  XAccessor<P> x;
  YAccessor<P> y;
  Extent? extent;

  Nodes<P>? nodes;
  IQuadtreeNode<P>? root;
}
