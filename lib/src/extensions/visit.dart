part of '../models/quadtree.dart';

typedef VisitCallback<P extends IPoint> = bool Function(
  IQuadtreeNode<P>? node,
  Extent extent,
);

extension VisitX<P extends IPoint> on Quadtree<P> {
  void visit(VisitCallback<P> callback) {
    final List<Quad<P>> quads = [];
    IQuadtreeNode<P>? node = root, child;
    late double x0, y0, x1, y1;

    if (node != null) quads.add(Quad(node, extent: _extent!));
    while (quads.isNotEmpty) {
      final q = quads.removeLast();
      if (!callback(
            node = q.node,
            Extent(
              x0 = q.extent.x0,
              y0 = q.extent.y0,
              x1 = q.extent.x1,
              y1 = q.extent.y1,
            ),
          ) &&
          node is IInternalNode<P> &&
          (node.nodes?.isNotEmpty ?? false)) {
        final xm = (x0 + x1) / 2, ym = (y0 + y1) / 2;
        if ((child = node.nodes![3]) != null)
          quads.add(Quad(child, extent: Extent(xm, ym, x1, y1)));
        if ((child = node.nodes![2]) != null)
          quads.add(Quad(child, extent: Extent(x0, ym, xm, y1)));
        if ((child = node.nodes![1]) != null)
          quads.add(Quad(child, extent: Extent(xm, y0, x1, ym)));
        if ((child = node.nodes![0]) != null)
          quads.add(Quad(child, extent: Extent(x0, y0, xm, ym)));
      }
    }
  }
}
