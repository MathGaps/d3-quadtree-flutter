import 'dart:math';

import 'package:d3_quadtree_flutter/src/interfaces/quadtree_node.dart';
import 'package:d3_quadtree_flutter/src/models/leaf.dart';
import 'package:d3_quadtree_flutter/src/models/quad.dart';
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
part '../extensions/remove.dart';
part '../extensions/size.dart';
part '../extensions/visit.dart';
part '../extensions/visit_after.dart';
part '../extensions/find.dart';
part '../extensions/data.dart';

class Quadtree<P extends IPoint> implements IInternalNode<P> {
  Quadtree({
    XAccessor<P>? x,
    YAccessor<P>? y,
    Extent? extent, // TODO: remove
  })  : _x = x ?? _defaultX,
        _y = y ?? _defaultY,
        _extent = extent;

  XAccessor<P> _x;
  set x(XAccessor<P> x) => _x = x;
  YAccessor<P> _y;
  set y(YAccessor<P> y) => _y = y;

  Extent? _extent;

  Nodes<P>? nodes;
  IQuadtreeNode<P>? root;

  Quadtree<P> get copy {
    return Quadtree<P>(
      x: _x,
      y: _y,
      extent: _extent,
    )
      ..nodes = Nodes(
        nw: nodes?.nw,
        ne: nodes?.ne,
        sw: nodes?.sw,
        se: nodes?.se,
      )
      ..root = root?.copy;
  }

  @override
  bool operator ==(Object o) =>
      o is Quadtree<P> &&
      _x == o._x &&
      _y == o._y &&
      _extent == o._extent &&
      nodes == o.nodes &&
      root == o.root;
  @override
  int get hashCode => hashObjects(
        [_x, _y, _extent, nodes, root],
      );
  @override
  String toString() {
    return {
      'root': root.toString(),
      'nodes': nodes.toString(),
      'extent': _extent.toString(),
    }.toString();
  }
}
