import 'package:d3_quadtree_flutter/d3_quadtree_flutter.dart';
import 'package:d3_quadtree_flutter/src/interfaces/point.dart';
import 'package:d3_quadtree_flutter/src/interfaces/quadtree_node.dart';

class Quad<P extends IPoint> {
  const Quad(
    this.node, {
    required this.extent,
  });

  final IQuadtreeNode<P>? node;
  final Extent extent;
}
