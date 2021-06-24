part of '../models/quadtree.dart';

extension AddX<P extends IPoint> on Quadtree<P> {
  void add(P point) {
    if (point.isNaN) return;

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

    double x0 = extent!.x0, y0 = extent!.y0, x1 = extent!.x1, y1 = extent!.y1;

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

    parent.nodes![j] = node;
    parent.nodes![i] = leaf;
  }
}
