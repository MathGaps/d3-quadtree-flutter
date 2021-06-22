import '../interfaces/point.dart';

typedef XAccessor<P extends IPoint> = double Function(P point);
typedef YAccessor<P extends IPoint> = double Function(P point);
