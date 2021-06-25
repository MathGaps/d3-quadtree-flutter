part of '../models/quadtree.dart';

extension ExtentX<P extends IPoint> on Quadtree<P> {
  Extent? extent([Extent? extent]) {
    if (extent != null) {
      this
        ..cover(
          extent.lowerBound.x,
          extent.lowerBound.y,
        )
        ..cover(
          extent.upperBound.x,
          extent.upperBound.y,
        );
    }
    return _extent;
  }
}
