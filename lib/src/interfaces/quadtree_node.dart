import 'package:d3_quadtree_flutter/src/interfaces/point.dart';
import 'package:d3_quadtree_flutter/src/models/extent.dart';
import 'package:d3_quadtree_flutter/src/models/nodes.dart';
import 'package:d3_quadtree_flutter/src/typedefs/accessors.dart';

/// Represents a node -- internal or leaf, of a quadtree.
abstract class IQuadtreeNode<P extends IPoint> {}

abstract class IInternalNode<P extends IPoint> implements IQuadtreeNode<P> {
  IInternalNode._(this.x, this.y);

  XAccessor<P> x;
  YAccessor<P> y;
  Extent? _extent;

  Nodes<P>? nodes;
  IQuadtreeNode<P>? root;
}

abstract class ILeafNode<P extends IPoint> implements IQuadtreeNode<P> {
  ILeafNode._(this.x, this.y);

  double x, y;
  ILeafNode<P>? next;

  external P get point;
  external bool get isNaN;
}
