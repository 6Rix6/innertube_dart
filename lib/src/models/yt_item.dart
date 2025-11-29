/// Base class for all YouTube Music items
abstract class YTItem {
  String get id;
  String get title;
  String? get thumbnail;
  bool get explicit;
  String get shareLink;

  const YTItem();
}
