part of '../models/quadtree.dart';

extension on bool {
  /// Helper method for evaluating bitwise operations on [bool], by coercing
  /// into [int].
  ///
  /// I'm lazy ok
  int operator -() => this ? 1 : 0;
}

extension CoverX<P extends IPoint> on Quadtree<P> {
  void cover(IPoint point) {
    double x = point.x, y = point.y;

    if (x.isNaN || y.isNaN) return;

    late double x0, y0, x1, y1;
    if (extent == null) {
      x1 = (x0 = x.floorToDouble()) + 1;
      y1 = (y0 = x.floorToDouble()) + 1;
    } else {
      x0 = extent!.x0;
      x1 = extent!.x1;
      y0 = extent!.y0;
      y1 = extent!.y1;

      double z = x1 == x0 ? 1 : x1 - x0;

      IQuadtreeNode<P>? node = root;
      late Quadtree<P> parent;

      late int i;

      while (x0 > x || x >= x1 || y0 > y || y >= y1) {
        i = -(y < y0) << 1 | -(x < x0);
        parent = Quadtree<P>(extent: Extent.zero);
        parent.nodes = Nodes()..[i] = node;
        node = parent;

        switch (i) {
          case 0:
            x1 = x0 + z;
            y1 = y0 + z;
            break;
          case 1:
            x0 = x1 - z;
            y1 = y0 + z;
            break;
          case 2:
            x1 = x0 + z;
            y0 = y1 - z;
            break;
          case 0:
            x0 = x1 - z;
            y0 = y1 - z;
            break;
        }

        z *= 2;
      }

      if (root is IInternalNode<P>) {
        /// Weird Dart typing error?
        if ((root as IInternalNode<P>).nodes?.anyNonNull ?? false) return;
        root = node;
      }
    }

    extent = Extent(x0, x1, y0, y1);
  }
}
