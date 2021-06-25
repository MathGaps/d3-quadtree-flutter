part of '../models/quadtree.dart';

extension AddX<P extends IPoint> on Quadtree<P> {
  void add(P point) {
    if (point.isNaN) return;
    cover(point.x, point.y);

    ILeafNode<P> leaf = Leaf(point);
    IInternalNode<P>? parent;
    IQuadtreeNode<P>? node = root;
    final dx = x(point), dy = y(point);

    late bool right, bottom;
    late double xm, ym, xp, yp;
    late int i, j;

    /// If the tree is empty, initialize the root as a leaf.
    if (node == null) {
      root = leaf;
      return;
    }

    double x0 = _extent!.x0,
        y0 = _extent!.y0,
        x1 = _extent!.x1,
        y1 = _extent!.y1;

    /// Find the existing leaf for the new point, or add it.
    //? This condition failing implies that [node] is [ILeafNode<P>]
    while (node is IInternalNode<P> && (node.nodes?.anyNonNull ?? false)) {
      if (right = dx >= (xm = (x0 + x1) / 2)) {
        x0 = xm;
      } else {
        x1 = xm;
      }

      if (bottom = dy >= (ym = (y0 + y1) / 2)) {
        y0 = ym;
      } else {
        y1 = ym;
      }

      parent = node;
      if ((node = node.nodes![i = -bottom << 1 | -right]) != null) {
        parent.nodes![i] = leaf;
        return;
      }
    }
    node = node as ILeafNode<P>;

    /// Is the new point exactly coincident with the existing point?
    xp = x(node.point);
    yp = y(node.point);
    if (dx == xp && dy == yp) {
      leaf.next = node;
      if (parent != null) {
        parent.nodes![i] = leaf;
      } else {
        root = leaf;
      }
      return;
    }

    /// Otherwise, split the leaf until the old and new point are separated.
    do {
      parent = parent != null
          ? parent.nodes![i] = Quadtree<P>()
          : root = Quadtree<P>();
      if (right = dx >= (xm = (x0 + x1) / 2)) {
        x0 = xm;
      } else {
        x1 = xm;
      }
      if (bottom = dy >= (ym = (y0 + y1) / 2)) {
        y0 = ym;
      } else {
        y1 = ym;
      }
    } while (
        (i = -bottom << 1 | -right) == (j = -(yp >= ym) << 1 | -(xp >= xm)));

    (parent.nodes ??= Nodes())
      ..[j] = node
      ..[i] = leaf;
  }

  void addAll(List<P> points) {
    late P p;
    late double dx, dy;
    final n = points.length;
    final List<double?> xz = List.filled(n, null), yz = List.filled(n, null);

    double x0 = double.infinity,
        y0 = double.infinity,
        x1 = double.infinity,
        y1 = double.infinity;

    /// Compute the points and their extent
    for (var i = 0; i < n; ++i) {
      if ((dx = x(p = points[i])).isNaN || (dy = y(p)).isNaN) continue;
      xz[i] = dx;
      yz[i] = dy;
      if (dx < x0) x0 = dx;
      if (dx > x1) x1 = dx;
      if (dy < y0) y0 = dy;
      if (dy > y1) y1 = dy;
    }

    /// If there were no (valid) points, abort
    if (x0 > x1 || y0 > y1) return;

    /// Expand the tree to cover the new points
    this..cover(x0, y0)..cover(x1, y1);

    /// Add the new points
    for (var i = 0; i < n; ++i) {
      this.add(points[i]);
    }
  }
}
