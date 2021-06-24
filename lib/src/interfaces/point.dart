abstract class IPoint {
  IPoint(this.x, this.y);

  double x;
  double y;

  bool get isNaN => x.isNaN || y.isNaN;
}
