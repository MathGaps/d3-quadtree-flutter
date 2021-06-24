part of '../models/quadtree.dart';

extension AddX<P extends IPoint> on Quadtree<P> {
  void add(IPoint point) {
    if (point.isNaN) return;

    Quadtree<P>? node = root;
  }
}
