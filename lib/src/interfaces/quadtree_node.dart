// ignore_for_file: unused_field

import 'package:d3_quadtree_flutter/src/interfaces/point.dart';
import 'package:d3_quadtree_flutter/src/models/extent.dart';
import 'package:d3_quadtree_flutter/src/models/nodes.dart';
import 'package:d3_quadtree_flutter/src/typedefs/accessors.dart';

/// Represents a node -- internal or leaf, of a quadtree.
abstract class IQuadtreeNode<P extends IPoint> {
  //! ONLY used in d3-force. Should abstract away, but I cba
  // TODO: allow full abstraction of IQuadtreeNodes and subclasses. Creation of
  // TODO: internal nodes can be handled by a callback IInternalNode Function(...)
  double? r, value, fx, fy;

  IQuadtreeNode<P> get copy;
}

abstract class IInternalNode<P extends IPoint> implements IQuadtreeNode<P> {
  IInternalNode._(this._x, this._y);

  XAccessor<P> _x;
  YAccessor<P> _y;
  Extent? _extent;

  Nodes<P>? nodes;
  IQuadtreeNode<P>? root;

  IInternalNode<P> get copy;
}

abstract class ILeafNode<P extends IPoint> implements IQuadtreeNode<P> {
  ILeafNode._(this.x, this.y);

  double x, y;
  ILeafNode<P>? next;

  P get point;
  bool get isNaN;
  ILeafNode<P> get copy;
}
