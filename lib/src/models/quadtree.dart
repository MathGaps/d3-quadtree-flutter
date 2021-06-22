import '../interfaces/point.dart';
import '../typedefs/accessors.dart';
import 'extent.dart';
import 'nodes.dart';

part '../extensions/x.dart';
part '../extensions/y.dart';
part '../extensions/cover.dart';

class Quadtree<P extends IPoint> {
  Quadtree({
    XAccessor? x,
    YAccessor? y,
    this.extent,
  })  : this.x = x ?? _defaultX,
        this.y = y ?? _defaultY;

  XAccessor<P> x;
  YAccessor<P> y;
  Extent? extent;
  Nodes<P>? nodes;
  Quadtree<P>? root;
}
