part of '../models/quadtree.dart';

extension DataX<P extends IPoint> on Quadtree<P> {
  List<P> data() {
    List<P> points = [];
    visit(
      (node, _) {
        if (node is ILeafNode<P>) {
          do {
            points.add((node as ILeafNode<P>).point);
          } while ((node = node.next) != null);
        }
        return false;
      },
    );
    return points;
  }
}
