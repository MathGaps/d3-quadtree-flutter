abstract class IPoint {
  IPoint(this.x, this.y);

  double x, y;

  bool get isNaN => x.isNaN || y.isNaN;

  IPoint get copy;
}
