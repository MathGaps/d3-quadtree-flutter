class Extent {
  const Extent(this.x0, this.x1, this.y0, this.y1);

  final double x0, x1, y0, y1;

  static const zero = Extent(0, 0, 0, 0);
}
