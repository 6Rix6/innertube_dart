import 'package:innertube_dart/src/models/accessibility_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'endpoints.dart';

part 'runs.g.dart';

/// Text runs with navigation endpoints
@JsonSerializable()
class Runs {
  final List<Run>? runs;
  final Accessibility? accessibility;

  const Runs({this.runs, this.accessibility});

  factory Runs.fromJson(Map<String, dynamic> json) => _$RunsFromJson(json);
  Map<String, dynamic> toJson() => _$RunsToJson(this);
}

@JsonSerializable()
class Run {
  final String text;
  final NavigationEndpoint? navigationEndpoint;

  const Run({required this.text, this.navigationEndpoint});

  factory Run.fromJson(Map<String, dynamic> json) => _$RunFromJson(json);
  Map<String, dynamic> toJson() => _$RunToJson(this);
}

/// Helper extensions for Run lists
extension RunsExtensions on List<Run> {
  /// Split runs by separator " • "
  List<List<Run>> splitBySeparator() {
    final res = <List<Run>>[];
    var tmp = <Run>[];

    for (final run in this) {
      if (run.text == ' • ') {
        res.add(tmp);
        tmp = <Run>[];
      } else {
        tmp.add(run);
      }
    }
    res.add(tmp);
    return res;
  }

  /// Get odd-indexed elements (0, 2, 4, ...)
  List<Run> oddElements() {
    return asMap().entries
        .where((entry) => entry.key % 2 == 0)
        .map((entry) => entry.value)
        .toList();
  }
}
