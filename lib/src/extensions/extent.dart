part of '../models/quadtree.dart';

extension ExtentX<P extends IPoint> on Quadtree<P> {
  Extent? extent([Extent? extent]) {
    if (extent != null) {
      this..cover(extent.lowerBound)..cover(extent.upperBound);
    }
    return _extent;
  }
}
