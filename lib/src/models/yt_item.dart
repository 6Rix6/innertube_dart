import 'package:innertube_dart/src/models/thumbnails.dart';

/// Base class for all YouTube Music items
abstract class YTItem {
  String get id;
  String get title;
  Thumbnails? get thumbnails;
  bool get explicit;
  String get shareLink;

  const YTItem();
}
