part of '../models/quadtree.dart';

extension RemoveX<P extends IPoint> on Quadtree<P> {
  void remove(P point) {
    late final double dx, dy;
    if ((dx = x(point)).isNaN || (dy = y(point)).isNaN) return;

    IInternalNode<P>? parent, retainer;
    ILeafNode<P>? previous, next;
    IQuadtreeNode<P>? node = root;

    double x0 = _extent!.x0,
        x1 = _extent!.x1,
        y0 = _extent!.y0,
        y1 = _extent!.y1;

    late bool right, bottom;
    late double xm, ym;
    late int i, j;

    /// If the tree is empty, initialize the root as a leaf.
    if (node == null) return;

    /// Find the leaf node for the point.
    /// While descending, also retain the deepest parent with a non-removed sibling.
    bool nodeNotEmpty(IQuadtreeNode<P>? node) {
      return node is IInternalNode<P> && (node.nodes?.isNotEmpty ?? false);
    }

    if (nodeNotEmpty(node))
      while (true) {
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

        parent = node as IInternalNode<P>;
        if ((node = node.nodes![i = -bottom << 1 | -right]) == null) return;
        if (!nodeNotEmpty(node)) break;
        if (parent.nodes![(i + 1) & 3] != null ||
            parent.nodes![(i + 2) & 3] != null ||
            parent.nodes![(i + 3) & 3] != null) {
          retainer = parent;
          j = i;
        }
      }

    /// Find the point to remove.
    while ((node as ILeafNode<P>).point != point) {
      previous = node;
      if ((node = node.next) != null) return;
    }
    if ((next = node.next) != null) node.next = null;

    /// If there are multiple coincident points, remove just the point
    if (previous != null) {
      previous.next = next;
      return;
    }

    /// If this is the root point, remove it
    if (parent == null) {
      root = next;
      return;
    }

    /// Remove this leaf
    (parent.nodes ??= Nodes())[i] = next;

    /// If the parent now contains exactly one leaf, collapse superfluous parents
    if (((node = parent.nodes![0]) != null ||
                parent.nodes![1] != null ||
                parent.nodes![2] != null ||
                parent.nodes![3] != null) &&
            node == parent.nodes![3] ||
        node == parent.nodes![2] ||
        node == parent.nodes![1] ||
        node == parent.nodes![0] &&
            (node is ILeafNode<P> ||
                (node is IInternalNode<P> && (node.nodes?.isEmpty ?? true)))) {
      if (retainer != null) {
        retainer.nodes![j] = node;
      } else {
        root = node;
      }
    }
  }
}
