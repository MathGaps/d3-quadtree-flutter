// ignore_for_file: unused_field

import 'package:d3_quadtree_flutter/src/interfaces/point.dart';
import 'package:d3_quadtree_flutter/src/models/extent.dart';
import 'package:d3_quadtree_flutter/src/models/nodes.dart';
import 'package:d3_quadtree_flutter/src/typedefs/accessors.dart';

/// Represents a node -- internal or leaf, of a quadtree.
abstract class IQuadtreeNode<P extends IPoint> {
  external IQuadtreeNode<P> get copy;
}

abstract class IInternalNode<P extends IPoint> implements IQuadtreeNode<P> {
  IInternalNode._(this._x, this._y);

  XAccessor<P> _x;
  YAccessor<P> _y;
  Extent? _extent;

  Nodes<P>? nodes;
  IQuadtreeNode<P>? root;

  external IInternalNode<P> get copy;
}

abstract class ILeafNode<P extends IPoint> implements IQuadtreeNode<P> {
  ILeafNode._(this.x, this.y);

  double x, y;
  ILeafNode<P>? next;

  external P get point;
  external bool get isNaN;
  external ILeafNode<P> get copy;
}
