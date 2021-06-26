part of '../models/quadtree.dart';

extension FindX<P extends IPoint> on Quadtree<P> {
  P? find(double x, double y, [double radius = double.infinity]) {
    P? point;
    double x0 = _extent!.x0,
        y0 = _extent!.y0,
        x3 = _extent!.x1,
        y3 = _extent!.y1;
    late double x1, y1, x2, y2;
    final List<Quad<P>> quads = [];

    IQuadtreeNode<P>? node = root;
    Quad<P>? q;
    late int i;

    if (node != null) quads.add(Quad(node, extent: Extent(x0, y0, x3, y3)));
    if (radius.isFinite) {
      x0 = x - radius;
      y0 = y - radius;
      x3 = x + radius;
      y3 = y + radius;
      radius *= radius;
    }

    while (quads.isNotEmpty) {
      q = quads.removeLast();

      // Stop searching if this quadrant can't contain a closer node.
      if ((node = q.node) == null ||
          (x1 = q.extent.x0) > x3 ||
          (y1 = q.extent.y0) > y3 ||
          (x2 = q.extent.x1) < x0 ||
          (y2 = q.extent.y1) < y0) continue;

      // Bisect the current quadrant
      if (node is IInternalNode<P> && (node.nodes?.isNotEmpty ?? false)) {
        final xm = (x1 + x2) / 2, ym = (y1 + y2) / 2;

        quads.addAll([
          Quad(node.nodes![3], extent: Extent(xm, ym, x2, y2)),
          Quad(node.nodes![2], extent: Extent(x1, ym, xm, y2)),
          Quad(node.nodes![1], extent: Extent(xm, y1, x2, ym)),
          Quad(node.nodes![0], extent: Extent(x1, y1, xm, ym)),
        ]);

        // Visit the closest quadrant first
        if ((i = (-(y >= ym) << 1) | -(x >= xm)) != 0) {
          final n = quads.length;
          q = quads[n - 1];
          quads[n - 1] = quads[n - 1 - i];
          quads[n - 1 - i] = q;
        }
      } else {
        // Visit this point. (visiting coincident points isn't necessary)
        node = node as ILeafNode<P>;
        final dx = x - _x(node.point),
            dy = y - _y(node.point),
            d2 = dx * dx + dy * dy;

        if (d2 < radius) {
          final d = sqrt(radius = d2);
          x0 = x - d;
          y0 = y - d;
          x3 = x + d;
          y3 = y + d;
          point = node.point;
        }
      }
    }

    return point;
  }
}
