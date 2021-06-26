part of '../models/quadtree.dart';

extension VisitAfterX<P extends IPoint> on Quadtree<P> {
  void visitAfter(VisitCallback<P> callback) {
    final List<Quad<P>> quads = [], next = [];
    IQuadtreeNode<P>? child;

    if (root != null) quads.add(Quad(root, extent: _extent!));

    while (quads.isNotEmpty) {
      final q = quads.removeLast();
      final node = q.node;

      if (node is IInternalNode<P> && (node.nodes?.isNotEmpty ?? false)) {
        double x0 = q.extent.x0,
            y0 = q.extent.y0,
            x1 = q.extent.x1,
            y1 = q.extent.y1,
            xm = (x0 + x1) / 2,
            ym = (y0 + y1) / 2;

        if ((child = node.nodes![0]) != null)
          quads.add(Quad(child, extent: Extent(x0, y0, xm, ym)));
        if ((child = node.nodes![1]) != null)
          quads.add(Quad(child, extent: Extent(xm, y0, x1, ym)));
        if ((child = node.nodes![2]) != null)
          quads.add(Quad(child, extent: Extent(x0, ym, xm, y1)));
        if ((child = node.nodes![3]) != null)
          quads.add(Quad(child, extent: Extent(xm, ym, x1, y1)));
      }
      next.add(q);
    }

    while (next.isNotEmpty) {
      final q = next.removeLast();
      callback(q.node, q.extent);
    }
  }
}
