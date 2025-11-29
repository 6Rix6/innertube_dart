/// Parses a time string to seconds
///
/// Examples:
/// - "3:45" -> 225 (3 minutes 45 seconds)
/// - "1:23:45" -> 5025 (1 hour 23 minutes 45 seconds)
/// - "45" -> 45 (45 seconds)
int? parseTime(String? time) {
  if (time == null || time.isEmpty) return null;

  try {
    final parts = time.split(':').reversed.toList();
    var seconds = 0;
    var multiplier = 1;

    for (final part in parts) {
      final value = int.tryParse(part);
      if (value == null) return null;

      seconds += value * multiplier;
      multiplier *= 60;
    }

    return seconds;
  } catch (e) {
    return null;
  }
}
