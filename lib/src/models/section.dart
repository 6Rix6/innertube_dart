import 'package:innertube_dart/innertube_dart.dart';

class Section {
  final String title;
  final List<YTItem>? items;
  final String? moreEndpoint;

  const Section({required this.title, this.items, this.moreEndpoint});

  @override
  String toString() {
    return 'Section(title: $title, items: ${items?.length}, moreEndpoint: $moreEndpoint)';
  }
}
