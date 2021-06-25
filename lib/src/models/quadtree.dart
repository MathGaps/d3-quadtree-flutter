import 'package:d3_quadtree_flutter/src/interfaces/quadtree_node.dart';
import 'package:d3_quadtree_flutter/src/models/leaf.dart';
import 'package:d3_quadtree_flutter/src/models/point.dart';
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
    XAccessor<P>? x,
    YAccessor<P>? y,
    Extent? extent, // TODO: remove
  })  : this.x = x ?? _defaultX,
        this.y = y ?? _defaultY,
        _extent = extent;

  XAccessor<P> x;
  YAccessor<P> y;
  Extent? _extent;

  Nodes<P>? nodes;
  IQuadtreeNode<P>? root;

  Quadtree<P> get copy {
    return Quadtree<P>(
      x: x,
      y: y,
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
      x == o.x &&
      y == o.y &&
      _extent == o._extent &&
      nodes == o.nodes &&
      root == o.root;
  @override
  int get hashCode => hashObjects(
        [x, y, _extent, nodes, root],
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
