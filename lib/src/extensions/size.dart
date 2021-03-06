part of '../models/quadtree.dart';

extension SizeX<P extends IPoint> on Quadtree<P> {
  int size() {
    int size = 0;
    visit(
      (node, _) {
        if (node is ILeafNode<P>) {
          do {
            node = node as ILeafNode<P>;
            size++;
          } while ((node = node.next) != null);
        }
        return false;
      },
    );
    return size;
  }
}
